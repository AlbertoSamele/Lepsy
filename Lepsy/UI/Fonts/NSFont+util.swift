import Cocoa

extension NSFont {
    static func appFonts(_ lepsyFont: any LepsyFont) -> NSFont? {
        lepsyFont.font
    }
}
