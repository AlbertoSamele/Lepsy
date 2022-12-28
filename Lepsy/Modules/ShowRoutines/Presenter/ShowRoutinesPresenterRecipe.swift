import Foundation

protocol ShowRoutinesPresenterRecipe {
    func presentRoutines(response: ShowRoutines.LoadRoutines.Response)
    func setSelectedRoutine(response: ShowRoutines.SelectRoutine.Response)
}
