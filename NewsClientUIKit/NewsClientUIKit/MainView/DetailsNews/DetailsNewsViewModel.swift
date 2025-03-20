//
//  DetailsNewsModel.swift
//  NewsClientUIKit
//
//  Created by Ruslan Liulka on 12.03.2025.
//

import Foundation
import SDWebImage
import CoreData

class DetailsNewsViewModel {
    
    let coreDataService = CoreDataService.shared
    
    
    func saveNews(with information: SavedArticles) {
        let context = coreDataService.context
        
        let savedNews = CDSavedNews(context: context)
        savedNews.title = information.title
        savedNews.author = information.author
        savedNews.content = information.content
        savedNews.descriptionLabel = information.description
        savedNews.name = information.source.name
        savedNews.publishedAt = information.publishedAt
        savedNews.url = information.url
        savedNews.image = information.urlToImage
        
        coreDataService.save(context: context)
    }
    
    
//    func saveNews(with information: SavedArticles) {
//        let context = coreDataService.backgroundContext
//        
//        let savedNews = CDNews(context: context)
//        savedNews.title = information.title
//        savedNews.descriptionLable = information.description
//        savedNews.name = information.source.name
//        savedNews.content = information.content
//        savedNews.publishTime = information.publishedAt
//        savedNews.author = information.author
//        savedNews.image = information.urlToImage
//        
//        self.coreDataService.save(context: context)
//        
//    }
    
    func deleteNews(with url: String) {
        let context = coreDataService.context
        
        let fetchRequest: NSFetchRequest<CDSavedNews> = CDSavedNews.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "url == %@", url)
        
        do {
            let result = try context.fetch(fetchRequest)
            
            if let newsToDelete = result.first {
                
                context.delete(newsToDelete)
                try context.save()
                print("Deleted")
            }
        } catch {
            print("Not delete")
        }
    }
}
