//
//  TopRepositoriesService.swift
//  GithubTopRepositories
//
//  Created by Elen de Souza on 11/05/19.
//  Copyright © 2019 Elen de Souza. All rights reserved.
//

// MARK: - Imports
import Moya

// MARK: - Typealias

// MARK: - Protocols
protocol TopRepositoriesServiceContract: class {
    func stars(page: Int, completion: @escaping (Result<RepositoriesResponse, Error>) -> Void)
}

// MARK: - Constantes

// MARK: - Enums
enum CommomErrors: Error {
    case decodableFailed
}

// MARK: - Class/Objects
class TopRepositoriesService: TopRepositoriesServiceContract {
    
    // MARK: - Vars
    
    // MARK: - Lets
    static let shared: TopRepositoriesServiceContract = TopRepositoriesService()
    private let apiClient: MoyaProvider<TopRepositoriesAPI>
    
    // MARK: - Initializers
    init(_ provider: MoyaProvider<TopRepositoriesAPI>) {
        self.apiClient = provider
    }
    
    private convenience init() {
        self.init(MoyaProvider<TopRepositoriesAPI>())
    }
    // MARK: - Overrides
    
    // MARK: - Public Methods
    func stars(page: Int, completion: @escaping (Result<RepositoriesResponse, Error>) -> Void) {
        apiClient.request(TopRepositoriesAPI.stars(page: page)) { result in
            switch result {
            case .success(let response):
                guard let result = try? JSONDecoder().decode(RepositoriesResponse.self, from: response.data) else {
                    completion(Result.failure(CommomErrors.decodableFailed))
                    return
                }
                completion(Result.success(result))
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    // MARK: - Private Methods
    
    // MARK: - Deinitializers
}
