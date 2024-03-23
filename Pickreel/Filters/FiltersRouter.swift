protocol FiltersRouterProtocol {
    func closeFilters(newFilter: Filter, completion: (Filter) -> Void)
}

class FiltersRouter: FiltersRouterProtocol {
    weak var viewController: FiltersViewController?
    
    func closeFilters(newFilter: Filter, completion: (Filter) -> Void) {
        completion(newFilter)
    }
}
