//
//  Constant.swift
//  NewsClientUIKit
//
//  Created by Ruslan Liulka on 07.03.2025.
//
import Foundation

enum Category: String, CaseIterable {
    case business
    case general
    case entertainment
    case health
    case science
    case sport
    case technology
}

enum EndPoints: String {
    case everything = "/v2/everything?"
    case topHeadLines = "/v2/top-headlines?"
}

struct ApiLink {
    private let mainLink = "https://newsapi.org"
    private let apiKey = "37beefb7966b4f568c9f18718ca7b11d"
    
    func buildUrl(endpoints: EndPoints, category: Category? = nil, search: String = "") -> URL? {
        
        let fullLink = mainLink + endpoints.rawValue
        var components = URLComponents(string: fullLink)
        var queryItems = [URLQueryItem]()
        
        
        if !search.isEmpty {
            queryItems.append(URLQueryItem(name: "q", value: search))
        }
        
        
        if let addCategory = category?.rawValue {
            queryItems.append(URLQueryItem(name: "category", value: addCategory))
        }
        
        queryItems.append(URLQueryItem(name: "apiKey", value: apiKey))
        
        components?.queryItems = queryItems
        return components?.url
    }
}



