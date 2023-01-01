import Cocoa

class RoutineCell: NSTableCellView {
    // MARK: - Static properties
    
    static var identifierValue = "RoutineCell"
    
    // MARK: - UI properties
    
    @objc
    private lazy var titleLabel = createTitleLabel()
    private let selectionColor: NSColor = .appColor(AppColors.Background.accent)
    
    // MARK: - Inits
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        titleLabel.textColor = .appColor(AppColors.Text.main)
        super.prepareForReuse()
    }
    
    // MARK: - Public methods
    
    func configure(title: String?, selected: Bool) {
        titleLabel.text = title
        setSelected(selected)
    }
    
    func setSelected(_ selected: Bool) {
        titleLabel.textColor = selected ? .appColor(AppColors.Text.accent) : .appColor(AppColors.Text.main)
    }
}

// MARK: - RoutineCell+UI

private extension RoutineCell {
    func createTitleLabel() -> LepsyLabel {
        let label = LepsyLabel()
        label.font = .appFonts(AppFonts.Regular.medium)
        label.textAlignment = .center
        return label
    }
    
    func setupLayout() {
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        let padding: CGFloat = .appSizing(AppSizing.Spacing.small)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding / 2),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding / 2),
        ])
    }
}
