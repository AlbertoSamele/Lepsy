import Cocoa

protocol LepsyFont: RawRepresentable where RawValue == CGFloat {
    var weight: NSFont.Weight { get }
    var name: String? { get }
}

extension LepsyFont {
    var weight: NSFont.Weight { .regular }
    var name: String? { nil }
}

extension LepsyFont {
    var font: NSFont? {
        guard let name else {
            return .systemFont(ofSize: rawValue, weight: weight)
        }
        return .init(name: name, size: rawValue)
    }
}
