//
//  Model.swift
//  NewsClientUIKit
//
//  Created by Ruslan Liulka on 06.03.2025.
//

import Foundation

struct NewsRequest: Codable {
    var status: String
    var totalResults: Int
    var articles: [Articles]
    
    
    struct Articles: Codable {
        var souce: Source
        var author: String
        var title: String
        var description: String
        var url: String
        var urlToImage: String
        var publishedAt: String
        var content: String


        
    }
    
    struct Source: Codable {
        var id: String
        var name: String
    }
}
