//
//  TopRepositoriesAPI.swift
//  GithubTopRepositories
//
//  Created by Elen de Souza on 11/05/19.
//  Copyright © 2019 Elen de Souza. All rights reserved.
//

import Moya

enum TopRepositoriesAPI {
    case stars(page: Int)
}

extension TopRepositoriesAPI: TargetType {
    var baseURL: URL {
        return URL(string: K.ApiServer.BaseUrl)!
    }
    
    var path: String {
        switch self {
        case .stars:
            return "/search/repositories"
        }
    }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        fatalError()
    }
    
    var task: Task {
        switch self {
        case .stars(let page):
            return .requestParameters(parameters: ["q" : "language:swift", "sort" : "stars", "page" : page],
                                      encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type" : "application/json"]
    }
    
}

