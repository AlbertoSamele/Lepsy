import Foundation

extension CGFloat {
    static func appSizing(_ lepsySizing: any LepsySizing) -> CGFloat {
        lepsySizing.size
    }
}
