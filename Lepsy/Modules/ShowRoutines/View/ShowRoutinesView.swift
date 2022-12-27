import Cocoa

class ShowRoutinesView: NSViewController {
    // MARK: - UI properties
    
    private lazy var routinesTableView = createTableView()
    
    // MARK: - Private properties
    
    var interactor: ShowRoutinesInteractorRecipe?
    
    // MARK: - Datasource properties
    
    private var routines: [String] = []
    
    // MARK: - Overriden properties
    
    override func loadView() {
        view = .init()
        view.wantsLayer = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        setupLayout()
        loadRoutines()
    }
    
    // MARK: - Private methods
    
    private func setupDelegates() {
        routinesTableView.delegate = self
        routinesTableView.dataSource = self
    }
    
    private func loadRoutines() {
        let request = ShowRoutines.LoadRoutines.Request()
        interactor?.loadRoutines(request: request)
    }
}

// MARK: - ShowRoutinesView+ShowRoutinesViewRecipe

extension ShowRoutinesView: ShowRoutinesViewRecipe {
    func displayRoutines(viewModel: ShowRoutines.LoadRoutines.ViewModel) {
        routines = viewModel.routines
        routinesTableView.reloadData()
    }
}

// MARK: - ShowRoutinesView+NSTableViewDelegate+NSTableViewDataSource

extension ShowRoutinesView: NSTableViewDelegate, NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        routines.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.dequeue(cell: { RoutineCell() }, identifier: RoutineCell.identifierValue)
        cell.configure(title: routines[row])
        return cell
    }
}

// MARK: - ShowRoutinesView+UI

private extension ShowRoutinesView {
    func createTableView() -> NSTableView {
        let tableView = NSTableView()
        tableView.headerView = nil
        tableView.addTableColumn(.init(identifier: .init(RoutineCell.identifierValue)))
        return tableView
    }
    
    func setupLayout() {
        view.layer?.backgroundColor = .appColor(AppColors.Background.main)
        
        [routinesTableView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            // Tableview
            routinesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            routinesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            routinesTableView.topAnchor.constraint(equalTo: view.topAnchor),
            routinesTableView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor),
        ])
    }
}
