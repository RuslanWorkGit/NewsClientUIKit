//
//  DetailsNewsViewModel.swift
//  NewsClientUIKit
//
//  Created by Ruslan Liulka on 20.03.2025.
//

import Foundation
import CoreData

class NewDetailsNewsViewModel {
    
    let coreData = CoreDataService.shared
    
    func save(with information: NewsRepresentable) {
        
        let context = coreData.context
        
        let savedNews = CDSavedNews(context: context)
        savedNews.title = information.newsTitle
        savedNews.name = information.newsSourceName
        savedNews.descriptionLabel = information.newsDescriptionText
        savedNews.author = information.newsAuthor
        savedNews.content = information.newsContent
        savedNews.image = information.newsImageData
        savedNews.url = information.newsUrl
        
        coreData.save(context: context)
        
    }
    
    func isElementExists(with url: String) -> Bool? {
        
        let context = coreData.context
        
        let fetchRequest: NSFetchRequest<CDSavedNews> = CDSavedNews.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: " url == %@", url)
        
        do {
            let result = try context.fetch(fetchRequest)
            
            if result.first != nil {
                return true
            } else {
                return false
            }
        } catch {
            print("Error: \(error.localizedDescription)")
            return nil
        }
    }
    
    func delete(with url: String) {
        
        let context = coreData.context
        let fetchRequest:NSFetchRequest<CDSavedNews> = CDSavedNews.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "url == %@", url)
        
        do {
            let result = try context.fetch(fetchRequest)
            if let newsToDelete = result.first {
                context.delete(newsToDelete)
                try context.save()
                print("Deleted")
            }
        } catch {
            print("Error to delete: \(error.localizedDescription)")
        }
    }
    
    
    
}
