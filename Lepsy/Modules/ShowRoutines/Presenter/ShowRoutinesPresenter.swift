import Foundation

class ShowRoutinesPresenter {
    // MARK: - Datasource properties
    
    var view: ShowRoutinesViewRecipe?
}

// MARK: - ShowRoutinesPresenter+ShowRoutinesPresenterRecipe

extension ShowRoutinesPresenter: ShowRoutinesPresenterRecipe {
    func presentRoutines(response: ShowRoutines.LoadRoutines.Response) {
        let viewModel = ShowRoutines.LoadRoutines.ViewModel(
            routines: response.routinesData.map(\.name),
            selectedRoutineIndex: 0
        )
        view?.displayRoutines(viewModel: viewModel)
    }
}
