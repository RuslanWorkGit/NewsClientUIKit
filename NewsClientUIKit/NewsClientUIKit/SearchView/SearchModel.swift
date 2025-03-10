//
//  SearchModel.swift
//  NewsClientUIKit
//
//  Created by Ruslan Liulka on 10.03.2025.
//

import Foundation

struct SearchRequest: Codable {
    var status: String
    var totalResults: Int
    var articles: [Articles]
    
}

