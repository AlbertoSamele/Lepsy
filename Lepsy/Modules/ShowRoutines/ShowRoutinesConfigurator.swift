import Cocoa

extension ShowRoutinesView {
    @discardableResult
    func configure() -> ShowRoutinesView {
        var interactor = ShowRoutinesInteractor()
        var presenter = ShowRoutinesPresenter()
        self.interactor = interactor
        interactor.presenter = presenter
        presenter.view = self
        
        return self
    }
}
