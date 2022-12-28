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
    
    // MARK: - Public methods
    
    func configure(title: String?, selected: Bool) {
        titleLabel.text = title
        setSelected(selected, animated: false)
    }
    
    func setSelected(_ selected: Bool, animated: Bool = true) {
        let backgroundColor: [Bool:NSColor] = [
            true: .appColor(AppColors.Background.accent),
            false: .appColor(AppColors.Background.main),
        ]
        let textColor: [Bool:NSColor] = [
            true: .appColor(AppColors.Text.accent),
            false: .appColor(AppColors.Text.main)
        ]
        
        titleLabel.layer?.opacity = 0.8
        titleLabel.textColor = textColor[selected]
        NSAnimationContext.runAnimationGroup { context in
            context.duration = animated ? 0.25 : 0
            animator().layer?.backgroundColor = backgroundColor[selected]?.cgColor
            titleLabel.animator().layer?.opacity = 1
        }
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
        wantsLayer = true
        layer?.cornerRadius = .appSizing(AppSizing.CornerRadius.small)
        
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
