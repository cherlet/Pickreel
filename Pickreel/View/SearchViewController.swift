import UIKit

protocol SearchViewProtocol: AnyObject {
    func show(history: [Media])
    func show(results: [Media])
}

class SearchViewController: UIViewController {
    // MARK: Variables
    var presenter: SearchPresenterProtocol?
    var history: [Media] = []
    var results: [Media] = []
    
    // MARK: UI Elements
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SearchCell.self, forCellReuseIdentifier: SearchCell.identifier)
        return tableView
    }()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewLoaded()
        initialize()
    }
}

// MARK: Module
extension SearchViewController: SearchViewProtocol {
    func show(history: [Media]) {
        self.history = history
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func show(results: [Media]) {
        self.results = results
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: Setup
private extension SearchViewController {
    func initialize() {
        tableView.delegate = self
        tableView.dataSource = self
        
        setupSearchController()
        setupLayout()
    }
    
    func setupLayout() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Фильмы, сериалы"
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

// MARK: Table
extension SearchViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        inSearchMode(searchController) ? results.count : history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as? SearchCell else {
            fatalError("DEBUG: Failed with custom cell bug")
        }
        
        let media = inSearchMode(searchController) ? results[indexPath.row] : history[indexPath.row]
        cell.configure(with: media)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 88 }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let media = inSearchMode(searchController) ? results[indexPath.row] : history[indexPath.row]
        let mediaViewController = MediaModuleBuilder.build(for: media)
        navigationController?.pushViewController(mediaViewController, animated: true)
    }
}

// MARK: - Search Controller
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        updateSearchController(searchBarText: searchController.searchBar.text)
    }
}

// MARK: - Search Functions
private extension SearchViewController {
    func inSearchMode(_ searchController: UISearchController) -> Bool {
        let isActive = searchController.isActive
        let searchText = searchController.searchBar.text ?? ""
        
        return isActive && !searchText.isEmpty
    }
    
    func updateSearchController(searchBarText: String?) {
        if let searchText = searchBarText, !searchText.isEmpty {
            presenter?.updateSearch(with: searchText.lowercased())
        }
        
        DispatchQueue.main.async { self.tableView.reloadData() }
    }
}
