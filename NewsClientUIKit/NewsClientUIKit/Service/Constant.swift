//
//  Constant.swift
//  NewsClientUIKit
//
//  Created by Ruslan Liulka on 07.03.2025.
//
import Foundation

enum Category: String {
    case business
    case general
    case entertainment
    case health
    case science
    case sport
    case technology
}

struct ApiLink {
    private let mainLink = "https://newsapi.org/v2/top-headlines?"
    private let apiKey = "37beefb7966b4f568c9f18718ca7b11d"
    
    func buildUrl(category: Category) -> URL? {
        var components = URLComponents(string: mainLink)
        var queryItems = [URLQueryItem]()
        
        queryItems.append(URLQueryItem(name: "category", value: category.rawValue))
        queryItems.append(URLQueryItem(name: "apiKey", value: apiKey))
        
        components?.queryItems = queryItems
        return components?.url
    }
}



