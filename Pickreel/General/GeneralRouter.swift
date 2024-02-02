protocol GeneralRouterProtocol {
    func openFilters(with filter: Filter, completion: @escaping (Filter) -> Void)
}

class GeneralRouter: GeneralRouterProtocol {
    weak var viewController: GeneralViewController?
    
    func openFilters(with filter: Filter, completion: @escaping (Filter) -> Void) {
        let vc = FiltersModuleBuilder.build(with: filter, completion: completion)
        viewController?.present(vc, animated: true)
    }
}
