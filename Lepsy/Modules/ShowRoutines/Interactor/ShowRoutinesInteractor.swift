import Foundation

class ShowRoutinesInteractor {
    // MARK: - Private properties
    
    var presenter: ShowRoutinesPresenterRecipe?
    
    // MARK: - Datasource proeprties
    
    private var routines: [Routine] = []
    
    // MARK: - Private methods
    
    private func fetchRoutines() -> [Routine] {
        routines = [
            .init(id: "id1", name: "First routine", phrases: []),
            .init(id: "id2", name: "Second routine", phrases: []),
            .init(id: "id3", name: "Third routine", phrases: [])
        ]
        return routines
    }
}

// MARK: - ShowRoutinesInteractor+ShowRoutinesInteractorRecipe

extension ShowRoutinesInteractor: ShowRoutinesInteractorRecipe {
    func loadRoutines(request: ShowRoutines.LoadRoutines.Request) {
        let response = ShowRoutines.LoadRoutines.Response(routinesData: fetchRoutines())
        presenter?.presentRoutines(response: response)
    }
    
    func selectRoutine(request: ShowRoutines.SelectRoutine.Request) {
        let response = ShowRoutines.SelectRoutine.Response(
            selectedRoutineData: routines[request.selectedRoutineIndex]
        )
        presenter?.setSelectedRoutine(response: response)
    }
}
