import Cocoa

protocol LepsyColor: RawRepresentable where RawValue == UInt32 {}

extension LepsyColor {
    var color: NSColor {
        .init(
            red: Double((rawValue >> 16) & 0xFF) / 255,
            green: Double((rawValue >> 08) & 0xFF) / 255,
            blue: Double((rawValue >> 00) & 0xFF) / 255,
            alpha: 1
        )
    }
}
