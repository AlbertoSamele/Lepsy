import Foundation

struct Routine: Equatable {
    static func == (lhs: Routine, rhs: Routine) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: String
    let name: String
    let phrases: [Phrase]
}
