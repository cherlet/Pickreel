protocol MediaPresenterProtocol: AnyObject {
    func viewLoaded()
}

class MediaPresenter {
    weak var view: MediaViewProtocol?
    
    private let media: Media

    init(media: Media) {
        self.media = media
    }
}

extension MediaPresenter: MediaPresenterProtocol {
    func viewLoaded() {
        view?.setup(with: media)
    }
}
