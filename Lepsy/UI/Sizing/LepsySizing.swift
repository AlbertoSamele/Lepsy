import Foundation

protocol LepsySizing: RawRepresentable where RawValue == CGFloat {}

extension LepsySizing {
    var size: CGFloat { rawValue }
}
