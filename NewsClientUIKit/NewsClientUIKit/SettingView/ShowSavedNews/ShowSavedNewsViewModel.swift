//
//  ShowSavedNewsViewModel.swift
//  NewsClientUIKit
//
//  Created by Ruslan Liulka on 13.03.2025.
//

import Foundation

class ShowSavedNewsViewModel {
    
    let coreDataService = CoreDataService.shared
    
    func deleteAll() {
        let context = coreDataService.context
        coreDataService.deleteAll(CDSavedNews.self)
        coreDataService.save(context: context)
    }
}
