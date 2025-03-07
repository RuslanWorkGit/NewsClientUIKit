//
//  MainViewModel.swift
//  NewsClientUIKit
//
//  Created by Ruslan Liulka on 07.03.2025.
//

import Foundation

class MainViewModel {
    
    private let networkService: NetworkServiceProtocol
    private let apiLink = ApiLink()
    
    var articles: NewsRequest?
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func fethcData(completion: @escaping (NewsRequest) -> Void) {
        
        guard let url = apiLink.buildUrl(category: .general) else {
            print("wrong link")
            return
        }
        
        networkService.fetch(with: url) { (result: Result<NewsRequest, Error>) in
            switch result {
            case .success(let newRequest):
                self.articles = newRequest
                completion(newRequest)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
