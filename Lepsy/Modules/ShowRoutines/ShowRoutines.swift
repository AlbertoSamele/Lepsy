import Foundation

enum ShowRoutines {
    enum LoadRoutines {
        struct Request {}
        
        struct Response {
            let routinesData: [Routine]
        }
        
        struct ViewModel {
            let routines: [String]
            let selectedRoutineIndex: Int
        }
    }
}
