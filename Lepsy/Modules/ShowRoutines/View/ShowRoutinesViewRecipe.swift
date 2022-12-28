import Foundation

protocol ShowRoutinesViewRecipe {
    func displayRoutines(viewModel: ShowRoutines.LoadRoutines.ViewModel)
    func updateSelectedRoutine(viewModel: ShowRoutines.SelectRoutine.ViewModel)
}
