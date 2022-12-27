import Cocoa

class MainViewController: NSViewController {
    // MARK: - UI properties
    
    private lazy var sidebarView = createSidebar()
    
    // MARK: - Overriden methods
    
    override func loadView() {
        view = NSView(frame: .init(
            origin: .zero,
            size: .init(width: 1000, height: 600)
        ))
        view.wantsLayer = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    // MARK: - Private methods
    
}

// MARK: - UI

private extension MainViewController {
    func createSidebar() -> NSView {
        let controller = ShowRoutinesView().configure()
        addChild(controller)
        return controller.view
    }
    
    func setupLayout() {
        [sidebarView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            // Sidebar
            sidebarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sidebarView.topAnchor.constraint(equalTo: view.topAnchor),
            sidebarView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            sidebarView.widthAnchor.constraint(greaterThanOrEqualToConstant: 200),
            sidebarView.widthAnchor.constraint(greaterThanOrEqualTo: view.widthAnchor, multiplier: 0.2),
        ])
    }
}

