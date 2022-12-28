import Foundation

protocol ShowRoutinesInteractorRecipe {
    func loadRoutines(request: ShowRoutines.LoadRoutines.Request)
    func selectRoutine(request: ShowRoutines.SelectRoutine.Request)
}
