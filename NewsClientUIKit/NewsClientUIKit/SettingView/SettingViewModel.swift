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
    
    
    
    func funcLoadData() -> [SavedArticles] {
        let context = coreDataService.context
        
        let fetchRequest: NSFetchRequest<CDSavedNews> = CDSavedNews.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            var articles: [SavedArticles] = []
            for result in results {
                
                let oneNews = SavedArticles(
                    source: Source(name: result.name ?? "No Name"),
                    author: result.author ?? "No Name",
                    title: result.title ?? "No Name",
                    description: result.descriptionLabel ?? "No Name",
                    url: result.url ?? "No Name",
                    urlToImage: result.image,
                    publishedAt: result.publishedAt ?? "No Name",
                    content: result.content ?? "No Name")
                
                articles.append(oneNews)
            }
            
            return articles
            
        } catch {
            print("Error to load data")
            return []
        }
        
        
    }
}
