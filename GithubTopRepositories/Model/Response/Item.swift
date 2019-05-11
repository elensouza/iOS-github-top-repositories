//
//  Item.swift
//  GithubTopRepositories
//
//  Created by Elen de Souza on 11/05/19.
//  Copyright © 2019 Elen de Souza. All rights reserved.
//

import Foundation

struct Item : Decodable {
    
    let name : String
    let owner : Owner
    let stargazersCount : Int
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case owner = "owner"
        case stargazersCount = "stargazers_count"
    }
    
}
