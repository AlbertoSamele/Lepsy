import Cocoa

enum AppFonts {
    enum Regular: CGFloat, LepsyFont {
        var weight: NSFont.Weight { .regular }
        
        case medium = 13
    }
}
