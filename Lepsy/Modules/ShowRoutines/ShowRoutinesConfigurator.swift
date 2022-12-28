import Cocoa

extension ShowRoutinesView {
    @discardableResult
    func configure() -> ShowRoutinesView {
        let interactor = ShowRoutinesInteractor()
        let presenter = ShowRoutinesPresenter()
        self.interactor = interactor
        interactor.presenter = presenter
        presenter.view = self
        
        return self
    }
}
