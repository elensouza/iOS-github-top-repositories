//
//  RepositoriesResponse.swift
//  GithubTopRepositories
//
//  Created by Elen de Souza on 11/05/19.
//  Copyright © 2019 Elen de Souza. All rights reserved.
//

import Foundation

struct RepositoriesResponse : Decodable {
    
    let incompleteResults : Bool
    let items : [Item]
    let totalCount : Int
    
    enum CodingKeys: String, CodingKey {
        case incompleteResults = "incomplete_results"
        case items = "items"
        case totalCount = "total_count"
    }
}
