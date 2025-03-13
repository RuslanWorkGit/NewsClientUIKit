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
    
    var newsRequest: NewsRequest?{
        didSet {
            updateNews!(newsRequest!)
        }
    }

    var updateNews: ((NewsRequest) -> Void)?
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func fethcData(category: Category) {
        
        guard let url = apiLink.buildUrl(endpoints: .topHeadLines ,category: category) else {
            print("wrong link")
            return
        }
        
        networkService.fetch(with: url) { (result: Result<NewsRequest, Error>) in
            switch result {
            case .success(let newRequest):
                self.newsRequest = newRequest
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
