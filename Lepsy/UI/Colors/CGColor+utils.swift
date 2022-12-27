import Cocoa

extension CGColor {
    static func appColor(_ lepsyColor: any LepsyColor) -> CGColor {
        lepsyColor.color.cgColor
    }
}
