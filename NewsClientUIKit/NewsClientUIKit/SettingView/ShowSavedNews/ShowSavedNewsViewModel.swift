//
//  ShowSavedNewsViewModel.swift
//  NewsClientUIKit
//
//  Created by Ruslan Liulka on 13.03.2025.
//

import Foundation
import CoreData

class ShowSavedNewsViewModel {
    
    let coreDataService = CoreDataService.shared
    
    func deleteAll() {
        let context = coreDataService.context
        coreDataService.deleteAll(CDSavedNews.self)
        coreDataService.save(context: context)
    }
    
    func delete(with url: String) {
        let context = coreDataService.context
        
        let fetchRequest: NSFetchRequest<CDSavedNews> = CDSavedNews.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "url == %@", url)
        
        do {
            let result = try context.fetch(fetchRequest)
            if let newsToDelete = result.first {
                context.delete(newsToDelete)
                try context.save()
                print("One News Delete")
            }
        } catch {
            print("error delete news: \(error.localizedDescription)")
        }
    }
}
