//
//  HomeViewController.swift
//  Ionix App
//
//  Created by Carlos Villamizar on 27/7/21.
//

import UIKit

protocol HomeDisplayLogic: AnyObject {
    func displayHome(viewModel: Home.Post.ViewModel, on queu: DispatchQueue)
    func displaySearchPost(viewModel: Home.SearchPost.ViewModel, on queu: DispatchQueue)
    func displayError(viewModel: Home.Error.ViewModel, on queu: DispatchQueue)
}

class HomeViewController: BaseViewController {
    
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var configButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let cellPostNibName = "PostTableViewCell"
    let cellNoResultsNibName = "NoResultsTableViewCell"
    var dataPost : [Children] = []
    
    var filteredPost : [Children] = []
    
    var isSearching = false
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .red
        refreshControl.addTarget(self, action: #selector(loadInitialData), for: .valueChanged)
        return refreshControl
    }()
    
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    
    // MARK: - Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        let viewController = self
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.clearBackground()
        settingTableView()
        loadInitialData()
        
        searchBar.delegate = self
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        hideKeyboardWhenTappedAround()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    // MARK: - Method
    
    @objc func loadInitialData() {
        showLoading()
        refresher.endRefreshing()
        isSearching = false
        let request = Home.Post.Request()
        interactor?.post(request: request)
    }
    
    func searchPost(query: String){
        let request = Home.SearchPost.Request(query: query)
        interactor?.searchPost(request: request)
    }
    
    private func settingTableView() {
        searchTableView.register(UINib(nibName: cellPostNibName, bundle: nil),
                           forCellReuseIdentifier: PostTableViewCell.reuseIdentifier)
        searchTableView.register(UINib(nibName: cellNoResultsNibName, bundle: nil),
                           forCellReuseIdentifier: NoResultsTableViewCell.reuseIdentifier)
        
        searchTableView.refreshControl = refresher
        
        searchTableView.rowHeight = UITableView.automaticDimension
        searchTableView.estimatedRowHeight = 100
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        searchBar.showsCancelButton = true
        searchTableView.reloadData()
    }
    
    func hideKeyboardWhenTappedAround() {
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        }

        @objc func dismissKeyboard() {
            view.endEditing(true)
        }
    
    // MARK: - Actions
    
    @IBAction func onClickConfiguration(_ sender: Any) {
        router?.routeToAccessCamera()
    }
}

// MARK: - HomeDisplayLogic

extension HomeViewController: HomeDisplayLogic {
    
    func displayHome(viewModel: Home.Post.ViewModel, on queu: DispatchQueue = .main) {
        hideLoading()
        
        let dataChild = viewModel.data.children
        
        dataPost = dataChild.filter{ $0.data.link_flair_text == "Shitposting" && $0.data.post_hint == "image" }
        
        refresher.endRefreshing()
        searchTableView.reloadData()
    }
    
    func displaySearchPost(viewModel: Home.SearchPost.ViewModel, on queu: DispatchQueue = .main) {
        hideLoading()
        filteredPost.removeAll()
        
        let dataChild = viewModel.data.children
        
        filteredPost = dataChild.filter{ $0.data.link_flair_text == "Shitposting" && $0.data.post_hint == "image" }
        
        refresher.endRefreshing()
        searchTableView.reloadData()
    }
    
    func displayError(viewModel: Home.Error.ViewModel, on queu: DispatchQueue = .main) {
        hideLoading()
        
        refresher.endRefreshing()
        displaySimpleAlert(with: "Error", message: viewModel.error.description)
    }
    
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            if filteredPost.isEmpty {
                return 1
            } else {
                return filteredPost.count
            }
        } else {
            return dataPost.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? PostTableViewCell else {
                                                        fatalError()
        }
        
        guard let cell2 = tableView.dequeueReusableCell(withIdentifier: NoResultsTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? NoResultsTableViewCell else {
                                                        fatalError()
        }

        
        if isSearching {
            if filteredPost.isEmpty {
                return cell2
            } else {
                cell.configUI(post: filteredPost[indexPath.row].data)
            }
        } else {
            cell.configUI(post: dataPost[indexPath.row].data)
        }
        
        return cell
    }
}

// MARK: - UISearchResultsUpdating

extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearching = true
        searchPost(query: searchText.lowercased())
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        isSearching = false
        searchBar.text = ""
        searchTableView.reloadData()
        searchBar.resignFirstResponder()
    }
}
