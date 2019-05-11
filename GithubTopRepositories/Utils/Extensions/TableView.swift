//
//  TableView.swift
//  GithubTopRepositories
//
//  Created by Elen de Souza - ESU on 11/05/19.
//  Copyright © 2019 Elen de Souza. All rights reserved.
//

import UIKit

extension UITableView {
    func registerNib<T: UITableViewCell>(_: T.Type, reuseIdentifier: String? = nil) {
        self.register(UINib(nibName: String(describing: T.self), bundle: nil), forCellReuseIdentifier: reuseIdentifier ?? String(describing: T.self))
    }
}
