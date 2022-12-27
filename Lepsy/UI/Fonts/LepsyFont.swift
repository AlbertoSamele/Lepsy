import Cocoa

protocol LepsyFont: RawRepresentable where RawValue == CGFloat {
    var weight: NSFont.Weight { get }
}

extension LepsyFont {
    var font: NSFont {
        .systemFont(ofSize: rawValue, weight: weight)
    }
}
