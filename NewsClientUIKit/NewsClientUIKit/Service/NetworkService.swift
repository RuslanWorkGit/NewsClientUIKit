//
//  NetworkService.swift
//  NewsClientUIKit
//
//  Created by Ruslan Liulka on 07.03.2025.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetch<T: Decodable>(with url: URL, completion: @escaping (Result<T, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    func fetch<T: Decodable>(with url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let responseError = error {
                
                DispatchQueue.main.async {
                    completion(.failure(responseError))
                }
      
            }
            
            guard let responseData = data else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "", code: -1,userInfo: [NSLocalizedDescriptionKey: "No recieved data!"])))
                }
                return
            }
            
            do {
                let decodeData = try JSONDecoder().decode(T.self, from: responseData)
                
                DispatchQueue.main.async {
                    completion(.success(decodeData))
                }
            } catch {
                completion(.failure(error))
                print("Error decode data: \(error.localizedDescription)")
            }
        }.resume()
    }
}
