//
//  TopRepositoriesViewModel.swift
//  GithubTopRepositories
//
//  Created by Elen de Souza on 11/05/19.
//  Copyright © 2019 Elen de Souza. All rights reserved.
//

import Foundation

protocol TopRepositoriesViewModelContract {
    init(_ view: TopRepositoriesViewControllerContract)
    
    var currentPage: Int { get }
    var repositories: [Item] { get }
    func getStars(_ page: Int)
}

class TopRepositoriesViewModel: TopRepositoriesViewModelContract {
    
    var currentPage: Int
    var repositories: [Item]
    
    let view: TopRepositoriesViewControllerContract
    
    required init(_ view: TopRepositoriesViewControllerContract) {
        self.view = view
        self.currentPage = 0
        self.repositories = [Item]()
    }
    
    func getStars(_ page: Int) {
        if page != 1 { self.view.showLoading() }
        TopRepositoriesService.shared.stars(page: page) { result in
            switch result {
            case .success(let result):
                self.currentPage = page
                if page == 1 {
                    self.repositories = []
                } else {
                    self.view.dismissLoading()
                }
                self.repositories.append(contentsOf: result.items)
                self.view.reloadTableView()
            case .failure(let error):
                self.view.showError(message: error.localizedDescription)
                self.view.dismissLoading()
            }
        }
    }
    
}
