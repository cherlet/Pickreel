protocol SettingsInteractorProtocol: AnyObject {
}

class SettingsInteractor: SettingsInteractorProtocol {
    weak var presenter: SettingsPresenterProtocol?
}
