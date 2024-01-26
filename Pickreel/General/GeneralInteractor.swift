protocol GeneralInteractorProtocol: AnyObject {
    func loadContent()
}

class GeneralInteractor: GeneralInteractorProtocol {
    weak var presenter: GeneralPresenterProtocol?
    
    func loadContent() {
        // logic of loading content
    }
}
