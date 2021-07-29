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

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var configButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let cellNibName = "PostTableViewCell"
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
        
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    // MARK: - Method
    
    @objc func loadInitialData() {
        isSearching = false
        let request = Home.Post.Request()
        interactor?.post(request: request)
    }
    
    func searchPost(query: String){
        let request = Home.SearchPost.Request(query: query)
        interactor?.searchPost(request: request)
    }
    
    private func settingTableView() {
        searchTableView.register(UINib(nibName: cellNibName, bundle: nil),
                           forCellReuseIdentifier: PostTableViewCell.reuseIdentifier)
        
        searchTableView.refreshControl = refresher
        
        searchTableView.rowHeight = UITableView.automaticDimension
        searchTableView.estimatedRowHeight = 100
    }
    
    // MARK: - Actions
    
    @IBAction func onClickConfiguration(_ sender: Any) {
        router?.routeToAccessCamera()
    }
}

// MARK: - HomeDisplayLogic

extension HomeViewController: HomeDisplayLogic {
    
    func displayHome(viewModel: Home.Post.ViewModel, on queu: DispatchQueue = .main) {
        
        let dataChild = viewModel.data.children
        
        dataPost = dataChild.filter{ $0.data.link_flair_text == "Shitposting" && $0.data.post_hint == "image" }
        
        refresher.endRefreshing()
        searchTableView.reloadData()

    }
    
    func displaySearchPost(viewModel: Home.SearchPost.ViewModel, on queu: DispatchQueue = .main) {
        filteredPost.removeAll()
        
        let dataChild = viewModel.data.children
        
        filteredPost = dataChild.filter{ $0.data.link_flair_text == "Shitposting" && $0.data.post_hint == "image" }
        
        refresher.endRefreshing()
        searchTableView.reloadData()
        
    }
    
    func displayError(viewModel: Home.Error.ViewModel, on queu: DispatchQueue = .main) {
        refresher.endRefreshing()
        print("Error", viewModel.error.description)
    }
    
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            return filteredPost.count
        } else {
            return dataPost.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? PostTableViewCell else {
                                                        fatalError()
        }
        
        if isSearching {
            cell.configUI(post: filteredPost[indexPath.row].data)
        } else {
            cell.configUI(post: dataPost[indexPath.row].data)
        }
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if isSearching {
//            let selectedWord = filteredPost[indexPath.row].data
//            print(selectedWord)
//        } else {
//            let selectedWord = dataPost[indexPath.row].data
//            print(selectedWord)
//        }
//
//        // Close keyboard when you select cell
//        if #available(iOS 13.0, *) {
//            self.searchBar.searchTextField.endEditing(true)
//        } else {
//            // Fallback on earlier versions
//        }
//    }
}

// MARK: - UISearchResultsUpdating

extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearching = true
        searchPost(query: searchText.lowercased())
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        searchTableView.reloadData()
    }
}
