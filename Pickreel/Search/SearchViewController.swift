import UIKit

protocol SearchViewProtocol: AnyObject {
    func initializeTable(with history: [Media])
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
        tableView.register(MediaCell.self, forCellReuseIdentifier: MediaCell.identifier)
        return tableView
    }()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewLoaded()
        initialize()
        
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: Module
extension SearchViewController: SearchViewProtocol {
    func initializeTable(with history: [Media]) {
        self.history = history
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: Setup
private extension SearchViewController {
    func initialize() {
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
        searchController.searchBar.placeholder = "Название фильма/сериала"
        
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MediaCell.identifier, for: indexPath) as? MediaCell else {
            fatalError("DEBUG: Failed with custom cell bug")
        }
        
        let media = inSearchMode(searchController) ? results[indexPath.row] : history[indexPath.row]
        cell.configure(with: media)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 100 }
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
        results = history
        
        if let searchText = searchBarText?.lowercased() {
            guard !searchText.isEmpty else {
                DispatchQueue.main.async { self.tableView.reloadData() }
                return
            }
            
            results = results.filter { $0.title.ru.lowercased().contains(searchText) }
        }
        
        DispatchQueue.main.async { self.tableView.reloadData() }
    }
}
