import Cocoa

extension NSColor {
    static func appColor(_ lepsyColor: any LepsyColor) -> NSColor {
        lepsyColor.color
    }
}
