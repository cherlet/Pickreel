protocol GeneralRouterProtocol {
    func openFilters()
}

class GeneralRouter: GeneralRouterProtocol {
    weak var viewController: GeneralViewController?
    
    func openFilters() {
        let vc = FiltersModuleBuilder.build()
        //vc.modalPresentationStyle = .overCurrentContext - input cut config later
        viewController?.present(vc, animated: true)
    }
}
