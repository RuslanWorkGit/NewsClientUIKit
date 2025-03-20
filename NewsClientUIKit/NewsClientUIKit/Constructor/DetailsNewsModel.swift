//
//  DetailsNewsModel.swift
//  NewsClientUIKit
//
//  Created by Ruslan Liulka on 20.03.2025.
//

import Foundation
import SDWebImage

protocol NewsRepresentable {
    var newsSourceName: String { get }
    var newsAuthor: String { get }
    var newsTitle: String { get }
    var newsDescriptionText: String { get }
    var newsContent: String { get }
    var newsImageData: Data? { get }
    var newsUrl: String { get }
    var publishedAt: String { get }
}


extension Articles: NewsRepresentable {
    var newsSourceName: String {
        return source.name
    }
    
    var newsAuthor: String {
        return author ?? ""
    }
    
    var newsTitle: String {
        return title
    }
    
    var newsDescriptionText: String {
        return description ?? ""
    }
    
    var newsContent: String {
        return content ?? ""
    }
    
    var newsImageData: Data? {
        
        let imagesStringUrl = urlToImage ?? ""
        let url = URL(string: imagesStringUrl)
        var data: Data?
        SDWebImageManager.shared.loadImage(with: url, options: .highPriority, progress: nil) { image, _ , _, _ , _ , _ in
            if let imageData = image?.pngData() {
                data = imageData
            }
        }
        return data
    }
    
    var newsUrl: String {
        return url
    }
    

    

}


extension SavedArticles: NewsRepresentable {
    var newsSourceName: String {
        return source.name
    }
    
    var newsAuthor: String {
        return author
    }
    
    var newsTitle: String {
        return title
    }
    
    var newsDescriptionText: String {
        return description
    }
    
    var newsContent: String {
        return content
    }
    
    var newsImageData: Data? {
        return urlToImage
    }
    
    var newsUrl: String {
        return url
    }
    
    
}
