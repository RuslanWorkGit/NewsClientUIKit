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
    
    func saveNews(with information: Articles) {
        let context = coreDataService.context
        
        let savedNews = CDNews(context: context)
        savedNews.title = information.title
        savedNews.descriptionLable = information.description
        savedNews.name = information.source.name
        savedNews.content = information.content
        savedNews.publishTime = information.publishedAt
        savedNews.author = information.author
        
        if let imageUrlString = information.urlToImage , let imageUrl = URL(string: imageUrlString) {
            
            SDWebImageManager.shared.loadImage(with: imageUrl, options: .highPriority, progress: nil) { image, _, _, _, _, _ in
                if let imageData = image?.pngData() {
                    savedNews.image = imageData
                }
                self.coreDataService.save(context: context)
            }
        } else {
            self.coreDataService.save(context: context)
        }
    }
    
    func deleteNews(with title: String) {
        let context = coreDataService.context
        
        let fetchRequest: NSFetchRequest<CDNews> = CDNews.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        
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
