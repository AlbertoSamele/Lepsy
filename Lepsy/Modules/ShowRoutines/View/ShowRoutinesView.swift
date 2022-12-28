import Cocoa

class ShowRoutinesView: NSViewController {
    // MARK: - Routine
    
    private struct Routine {
        let name: String
        let selected: Bool
    }
    
    // MARK: - UI properties
    
    private lazy var logoView = createLogoView()
    private lazy var routinesTableView = createTableView()
    
    // MARK: - Private properties
    
    var interactor: ShowRoutinesInteractorRecipe?
    
    // MARK: - Datasource properties
    
    private var routines: [Routine] = []
    
    // MARK: - Overriden properties
    
    override func loadView() {
        view = .init()
        view.wantsLayer = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        setupLayout()
        interactor?.loadRoutines(request: .init())
    }
    
    // MARK: - Private methods
    
    private func setupDelegates() {
        routinesTableView.delegate = self
        routinesTableView.lepsyDelegate = self
        routinesTableView.dataSource = self
    }
}

// MARK: - ShowRoutinesView+ShowRoutinesViewRecipe

extension ShowRoutinesView: ShowRoutinesViewRecipe {
    func displayRoutines(viewModel: ShowRoutines.LoadRoutines.ViewModel) {
        routines = viewModel.routines.enumerated().map {
            .init(name: $0.element, selected: $0.offset == viewModel.selectedRoutineIndex)
        }
        routinesTableView.reloadData()
    }
    
    func updateSelectedRoutine(viewModel: ShowRoutines.SelectRoutine.ViewModel) {
        if let previousSelectionIndex = viewModel.previousSelectedRoutineIndex,
           let previousView = routinesTableView.view(atColumn: 0, row: previousSelectionIndex, makeIfNecessary: false) as? RoutineCell
        {
            previousView.setSelected(false)
        }
        
        if let currentView = routinesTableView.view(atColumn: 0, row: viewModel.newSelectedRoutineIndex, makeIfNecessary: false) as? RoutineCell {
            currentView.setSelected(true)
        }
    }
}

// MARK: - ShowRoutinesView+LepsyTableViewDelegate+NSTableViewDelegate+NSTableViewDataSource

extension ShowRoutinesView: LepsyTableViewDelegate, NSTableViewDelegate, NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        routines.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.dequeue(cell: { RoutineCell() }, identifier: RoutineCell.identifierValue)
        let routine = routines[row]
        cell.configure(title: routine.name, selected: routine.selected)
        return cell
    }
    
    func tableView(_ tableView: NSTableView, didSelectRowAt row: Int, column: Int) {
        interactor?.selectRoutine(request: .init(selectedRoutineIndex: row))
    }
}

// MARK: - ShowRoutinesView+UI

private extension ShowRoutinesView {
    func createLogoView() -> NSView {
        let label = LepsyLabel()
        label.text = "Lepsy"
        label.font = .appFonts(AppFonts.Sylized.large)
        label.textColor = .appColor(AppColors.Text.secondary)
        label.textAlignment = .center
        return label
    }
    
    func createTableView() -> LepsyTableView {
        let tableView = LepsyTableView()
        tableView.headerView = nil
        tableView.style = .plain
        tableView.selectionHighlightStyle = .none
        tableView.focusRingType = .none
        tableView.addTableColumn(.init(identifier: .init(RoutineCell.identifierValue)))
        return tableView
    }
    
    func setupLayout() {
        view.layer?.backgroundColor = .appColor(AppColors.Background.main)
        
        [logoView, routinesTableView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        let padding: CGFloat = .appSizing(AppSizing.Spacing.medium)
        NSLayoutConstraint.activate([
            // Logo
            logoView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoView.widthAnchor.constraint(equalTo: view.widthAnchor),
            // Tableview
            routinesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            routinesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            routinesTableView.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: padding),
            routinesTableView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -padding),
        ])
    }
}
