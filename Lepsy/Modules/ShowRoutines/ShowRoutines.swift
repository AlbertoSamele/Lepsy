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
    
    enum SelectRoutine {
        struct Request {
            let selectedRoutineIndex: Int
        }
        
        struct Response {
            let selectedRoutineData: Routine
        }
        
        struct ViewModel {
            let previousSelectedRoutineIndex: Int?
            let newSelectedRoutineIndex: Int
        }
    }
}
