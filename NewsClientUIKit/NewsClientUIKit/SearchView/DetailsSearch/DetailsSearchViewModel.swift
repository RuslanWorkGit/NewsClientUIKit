//
//  DetailsSearchViewModel.swift
//  NewsClientUIKit
//
//  Created by Ruslan Liulka on 23.03.2025.
//

class DetailsSearchViewModel {
    
    private let networkService: NetworkServiceProtocol
    private let apiLink = ApiLink()
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func aditionalSearch(searchString: String, page: Int, completion: @escaping ((SearchRequest) -> Void)) {
        
        guard let url = apiLink.buildUrl(endpoints: .everything, search: searchString, page: page) else { return }
        
        networkService.fetch(with: url) { (result: Result<SearchRequest, Error>) in
            switch result {
            case .success(let success):
                completion(success)
            case .failure(let error):
                print(error)
            }
        }
    }
}
