import Foundation

class ShowRoutinesPresenter {
    // MARK: - Private properties
    
    var view: ShowRoutinesViewRecipe?
    
    // MARK: - Datasource properties
    
    private var routines: [Routine] = []
    private var selectedRoutine: Routine?
}

// MARK: - ShowRoutinesPresenter+ShowRoutinesPresenterRecipe

extension ShowRoutinesPresenter: ShowRoutinesPresenterRecipe {
    func presentRoutines(response: ShowRoutines.LoadRoutines.Response) {
        selectedRoutine = response.routinesData.first
        routines = response.routinesData
        
        let viewModel = ShowRoutines.LoadRoutines.ViewModel(
            routines: routines.map(\.name),
            selectedRoutineIndex: 0
        )
        view?.displayRoutines(viewModel: viewModel)
    }
    
    func setSelectedRoutine(response: ShowRoutines.SelectRoutine.Response) {
        guard let newSelectionIndex = routines.firstIndex(of: response.selectedRoutineData) else {
            return
        }
        
        var previousSelectionIndex: Int?
        if let selectedRoutine {
            previousSelectionIndex = routines.firstIndex(of: selectedRoutine)
        }
        selectedRoutine = response.selectedRoutineData
        
        let viewModel = ShowRoutines.SelectRoutine.ViewModel(
            previousSelectedRoutineIndex: previousSelectionIndex,
            newSelectedRoutineIndex: newSelectionIndex
        )
        view?.updateSelectedRoutine(viewModel: viewModel)
    }
}
