import Cocoa

enum AppFonts {
    enum Regular: CGFloat, LepsyFont {
        var name: String? { "IBMPlexSansCond-Regular" }
        
        case medium = 15
    }
    
    enum Medium: CGFloat, LepsyFont {
        var name: String? { "IBMPlexSansCond-Medium" }
        
        case medium = 15
    }
    
    enum Semibold: CGFloat, LepsyFont {
        var name: String? { "IBMPlexSansCond-SemiBold" }
        
        case medium = 15
    }
    
    enum Sylized: CGFloat, LepsyFont {
        var name: String? { "RoyalAcidbath" }
        
        case large = 60
    }
}
