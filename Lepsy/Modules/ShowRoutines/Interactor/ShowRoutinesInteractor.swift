import Foundation

class ShowRoutinesInteractor {
    // MARK: - Private properties
    
    var presenter: ShowRoutinesPresenterRecipe?
    
    // MARK: - Private methods
    
    private func fetchRoutines() -> [Routine] {
        [
            .init(id: "id1", name: "First routine", phrases: []),
            .init(id: "id2", name: "Second routine", phrases: []),
            .init(id: "id3", name: "Third routine", phrases: [])
        ]
    }
}

// MARK: - ShowRoutinesInteractor+ShowRoutinesInteractorRecipe

extension ShowRoutinesInteractor: ShowRoutinesInteractorRecipe {
    func loadRoutines(request: ShowRoutines.LoadRoutines.Request) {
        let response = ShowRoutines.LoadRoutines.Response(routinesData: fetchRoutines())
        presenter?.presentRoutines(response: response)
    }
}
