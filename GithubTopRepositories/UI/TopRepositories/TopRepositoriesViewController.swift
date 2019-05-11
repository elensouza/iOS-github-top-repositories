//
//  TopRepositoriesViewController.swift
//  GitTopUsers
//
//  Created by Elen de Souza on 11/05/19.
//  Copyright © 2019 Elen de Souza. All rights reserved.
//

// MARK: - Imports
import UIKit
import SkeletonView

// MARK: - Typealias

// MARK: - Protocols
protocol TopRepositoriesViewControllerContract {
    func showLoading()
    func dismissLoading()
    func showError(message: String)
    func reloadTableView()
}

// MARK: - Constantes

// MARK: - Enums

// MARK: - Class/Objects
class TopRepositoriesViewController: UIViewController, TopRepositoriesViewControllerContract {
   
    
    static func instantiate() -> TopRepositoriesViewController {
        let vc = TopRepositoriesViewController(nibName: String(describing: TopRepositoriesViewController.self), bundle: nil)
        vc.viewModel = TopRepositoriesViewModel(vc)
        return vc
    }
    
    // MARK: - Propriedades (Getters & Setters)
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Vars
    private var canLoadMore: Bool = true

    // MARK: - Lets
    var viewModel: TopRepositoriesViewModelContract?
    
    // MARK: - Initializers
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.registerNib(RepositoryTableViewCell.self)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(reloadFirstPage), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
        
        loadRepositories(1)
    }
    
    // MARK: - Public Methods
    func showLoading() {
        print("Carregando")
    }
    
    func dismissLoading() {
        print("Parou de carregar")
    }
    
    func reloadTableView() {
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
        self.canLoadMore = true
    }
    
    func showError(message: String) {
        print(message)
    }
    
    // MARK: - Private Methods
    private func loadRepositories(_ page: Int) {
        viewModel?.getStars(page)
    }
    
    @objc private func reloadFirstPage() {
        self.canLoadMore = false
        loadRepositories(1)
    }
    
    // MARK: - Deinitializers
    
}

// MARK: - Extensions
extension TopRepositoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.viewModel?.repositories.count ?? 0) == 0 ? 20 : (self.viewModel?.repositories.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        if (self.viewModel?.repositories.count ?? 0) == 0 {
            cell.contentView.showAnimatedGradientSkeleton()
            tableView.isUserInteractionEnabled = false
        } else if let item = self.viewModel?.repositories[indexPath.row] {
            cell.contentView.stopSkeletonAnimation()
            cell.textLabel?.text = "\(item.name)"
            tableView.isUserInteractionEnabled = true
        }
        
        return cell
    }
}

extension TopRepositoriesViewController: UITableViewDelegate, UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height

        if maximumOffset - currentOffset <= 10.0 {
            if let current = self.viewModel?.currentPage,
                current < 34 && self.canLoadMore {
                loadRepositories(current + 1)
            }
        }
    }
}
