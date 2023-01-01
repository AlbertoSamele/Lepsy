import Cocoa

class LepsyLabel: NSView {
    // MARK: - UI properties
    
    private lazy var textField = createTextField()
    
    // MARK: - Datasource properties
    
    var text: String? {
        get { textField.stringValue }
        set {
            textField.stringValue = newValue ?? ""
            textField.sizeToFit()
        }
    }
    
    var font: NSFont? {
        get { textField.font }
        set {
            textField.font = newValue
            textField.sizeToFit()
        }
    }
    
    var textColor: NSColor? {
        get { textField.textColor }
        set { textField.textColor = newValue}
    }
    
    var textAlignment: NSTextAlignment {
        get { textField.alignment }
        set {
            textField.alignment = newValue
            textField.sizeToFit()
        }
    }
    
    var lineBreakMode: NSLineBreakMode {
        get { textField.lineBreakMode }
        set { textField.lineBreakMode = newValue }
    }
    
    // MARK: - Inits
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        loadDefaultValues()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - LepsyLabel+UI

private extension LepsyLabel {
    func createTextField() -> NSTextField {
        let textField = NSTextField()
        textField.wantsLayer = true
        textField.drawsBackground = false
        textField.isBezeled = false
        textField.isEditable = false
        return textField
    }
    
    func loadDefaultValues() {
        text = nil
        textColor = .appColor(AppColors.Text.main)
        font = .appFonts(AppFonts.Regular.medium)
        textAlignment = .left
        lineBreakMode = .byTruncatingTail
    }
    
    func setupLayout() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
