//
//  SettingViewModel.swift
//  NewsClientUIKit
//
//  Created by Ruslan Liulka on 07.03.2025.
//

import Foundation
import UIKit
import CoreData

class SettingViewModel {
    
    let coreDataService = CoreDataService.shared
    
    
    
    func funcLoadData() -> [SavedNews] {
        let context = coreDataService.context
        
        let fetchRequest: NSFetchRequest<CDSavedNews> = CDSavedNews.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            var articles: [SavedNews] = []
            for result in results {
                
                let oneNews = SavedNews(author: result.author ?? "Unknown author",
                                    content: result.content ?? "No content",
                                        description: result.descriptionLabel ?? "No Description",
                                        image: (result.image != nil ?  UIImage(data: result.image!) : UIImage(named: "basicNews.jpg"))!,
                                    name: result.name ?? "No Name",
                                        publishTime: result.publishedAt ?? "No published time",
                                    title: result.title ?? "No title")
                
                articles.append(oneNews)
            }
            
            return articles
            
        } catch {
            print("Error to load data")
            return []
        }
        
        
    }
}
