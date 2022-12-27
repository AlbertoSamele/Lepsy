import Cocoa

class RoutineCell: NSTableCellView {
    // MARK: - Static properties
    
    static var identifierValue = "RoutineCell"
    
    // MARK: - UI properties
    
    private lazy var titleLabel = createTitleLabel()
    
    // MARK: - Inits
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func configure(title: String?) {
        titleLabel.text = title
    }
}

// MARK: - RoutineCell+UI

private extension RoutineCell {
    func createTitleLabel() -> LepsyLabel {
        let label = LepsyLabel()
        label.textAlignment = .center
        return label
    }
    
    func setupLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
