import UIKit

protocol SearchViewProtocol: AnyObject {
}

class SearchViewController: UITableViewController {
    var presenter: SearchPresenterProtocol?

    // MARK: UI Elements
    private var searchController: UISearchController!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

// MARK: Module 
extension SearchViewController: SearchViewProtocol {
}

// MARK: Setup
extension SearchViewController:  UISearchResultsUpdating, UISearchBarDelegate {
    func initialize() {
    }
    
    func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск по названию, актеру и году"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.tintColor = ThemeColor.oppColor
    }
    
    func setupTableView() {
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        //
    }
}

// MARK: Table
extension SearchViewController {
}
