//
//  Owner.swift
//  GithubTopRepositories
//
//  Created by Elen de Souza on 11/05/19.
//  Copyright © 2019 Elen de Souza. All rights reserved.
//

import Foundation

struct Owner : Decodable {
    
    let avatarUrl : String
    let login : String
    
    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
        case login = "login"
    }
}
