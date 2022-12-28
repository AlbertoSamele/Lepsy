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
    private lazy var selectionIndicator = createSelectionIndicator()
    private var selectionIndicatorCenterYConstraint: NSLayoutConstraint?
    
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
    
    private func setCell(at index: Int, selected: Bool) {
        guard let cell = routinesTableView.view(atColumn: 0, row: index, makeIfNecessary: true) as? RoutineCell else {
            return
        }
        
        var selectionDelay: CGFloat = 0
        if selected {
            let animationDuration: CGFloat = 0.25
            selectionDelay = animationDuration * 0.4
            NSAnimationContext.runAnimationGroup { context in
                context.duration = animationDuration
                context.allowsImplicitAnimation = true
                
                selectionIndicatorCenterYConstraint?.isActive = false
                selectionIndicatorCenterYConstraint = selectionIndicator.centerYAnchor.constraint(equalTo: cell.centerYAnchor)
                selectionIndicatorCenterYConstraint?.isActive = true
                
                view.layoutSubtreeIfNeeded()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + selectionDelay) {
            cell.setSelected(selected)
        }
    }
}

// MARK: - ShowRoutinesView+ShowRoutinesViewRecipe

extension ShowRoutinesView: ShowRoutinesViewRecipe {
    func displayRoutines(viewModel: ShowRoutines.LoadRoutines.ViewModel) {
        routines = viewModel.routines.enumerated().map {
            .init(name: $0.element, selected: $0.offset == viewModel.selectedRoutineIndex)
        }
        routinesTableView.reloadData()
        setCell(at: viewModel.selectedRoutineIndex, selected: true)
    }
    
    func updateSelectedRoutine(viewModel: ShowRoutines.SelectRoutine.ViewModel) {
        if let previousSelectionIndex = viewModel.previousSelectedRoutineIndex {
            setCell(at: previousSelectionIndex, selected: false)
        }
        setCell(at: viewModel.newSelectedRoutineIndex, selected: true)
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
    
    func createSelectionIndicator() -> NSView {
        let view = NSView()
        view.wantsLayer = true
        view.layer?.backgroundColor = .appColor(AppColors.Background.accent)
        view.layer?.cornerRadius = .appSizing(AppSizing.CornerRadius.small)
        return view
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
        
        [logoView, selectionIndicator, routinesTableView].forEach {
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
            // Selection indicator
            selectionIndicator.widthAnchor.constraint(equalTo: routinesTableView.widthAnchor, multiplier: 0.9),
            selectionIndicator.heightAnchor.constraint(equalToConstant: 25),
            selectionIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}
