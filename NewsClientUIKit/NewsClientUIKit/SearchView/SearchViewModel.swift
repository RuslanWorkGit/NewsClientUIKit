//
//  SearchViewModel.swift
//  NewsClientUIKit
//
//  Created by Ruslan Liulka on 07.03.2025.
//

import Foundation

class SearchViewModel {
    
    private let networkService: NetworkServiceProtocol
    private let apiLink = ApiLink()
    
    var searchRequest: SearchRequest? {
        didSet{
            updateRequest!(searchRequest!)
        }
    }
    var updateRequest: ((SearchRequest) -> Void)?
    
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchSearchData(with searchInfo: String, sortByPopularity: Bool , completion: @escaping ((SearchRequest) -> Void)) {
        guard let url = apiLink.buildUrl(endpoints: .everything, search: searchInfo) else {
            print("Wrong Link")
            return
        }
        
        print(url)
        
        networkService.fetch(with: url) { (result: Result<SearchRequest, Error>) in
            switch result {
            case .success(let success):
                self.searchRequest = success
                completion(success)
            case .failure(let failure):
                print("Error fetch data!")
            }
        }
        
    }
    
    
}
