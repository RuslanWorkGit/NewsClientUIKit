//
//  MainViewModel.swift
//  NewsClientUIKit
//
//  Created by Ruslan Liulka on 07.03.2025.
//

import Foundation
import CoreData
import SDWebImage

class MainViewModel {
    
    private let networkService: NetworkServiceProtocol
    private let coreData = CoreDataService.shared
    private let apiLink = ApiLink()
    
    var newsRequest: NewsRequest?{
        didSet {
            guard let newsRequest = newsRequest else { return }
            updateNews?(newsRequest)
        }
    }

    var updateNews: ((NewsRequest) -> Void)?
    
   
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func fethcData(category: Category, savedComletion: @escaping (([SavedArticles]) -> Void)) {
        
        guard let url = apiLink.buildUrl(endpoints: .topHeadLines ,category: category) else {
            print("wrong link")
            return
        }
        
        networkService.fetch(with: url) { (result: Result<NewsRequest, Error>) in
            
            switch result {
            case .success(let newRequest):
                //self.newsRequest = newRequest
                self.savetoCoreData(articles: newRequest.articles, category: category.rawValue)
                
                DispatchQueue.main.async {
                    let savedNews = self.fetсhSavedData(category: category.rawValue)
                    savedComletion(savedNews.map {$0.toArticle()})
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func savetoCoreData(articles: [Articles], category: String) {
        
        let context = coreData.context
        
        for article in articles {
        
            var newSavedNews: CDNews?
            
            if let existed = fetсhSavedItem(url: article.url) {
                newSavedNews = existed
            } else {
                newSavedNews = insert()
            }
            
            //let savedNews = CDNews(context: backgroundContext)
            
            guard let savedNews = newSavedNews else {
                assertionFailure("SMTH GO WRONG!")
                return
            }
            
            savedNews.title = article.title
            savedNews.descriptionLable = article.description
            savedNews.name = article.source.name
            savedNews.author = article.author
            savedNews.content = article.content
            savedNews.publishTime = article.publishedAt
            savedNews.url = article.url
            savedNews.category = category
            
           
            if let imageUrlString = article.urlToImage, let url = URL(string: imageUrlString) {
                
                SDWebImageManager.shared.loadImage(with: url, options: .highPriority, progress: nil) { image, _, _, _, _, _ in
                    if let imageData = image?.pngData() {
                        savedNews.image = imageData
                    }
                }
                self.coreData.save(context: context)
            } else {
                self.coreData.save(context: context)
            }
        }
    }
    
    func fetсhSavedData(category: String) -> [CDNews] {
        let fetchRequest: NSFetchRequest<CDNews> = NSFetchRequest(entityName: "CDNews")
        fetchRequest.predicate = NSPredicate(format: "category == %@", category)
        
        let sortDescriptor = NSSortDescriptor(key: "publishTime", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let context = coreData.context
        
        do {
            let result = try context.fetch(fetchRequest)
            return result
            
        } catch {
            print("Error fethc data: \(error.localizedDescription)")
            return []
        }
        
    }
    
    func fetсhSavedItem(url: String) -> CDNews? {
        let fetchRequest: NSFetchRequest<CDNews> = NSFetchRequest(entityName: "CDNews")
        fetchRequest.predicate = NSPredicate(format: "url == %@", url)
        
        //let sortDescriptor = NSSortDescriptor(key: "publishTime", ascending: false)
        //fetchRequest.sortDescriptors = [sortDescriptor]
        
        let context = coreData.context
        
        do {
            let result = try context.fetch(fetchRequest).first
            return result
            
        } catch {
            print("Error fethc data: \(error.localizedDescription)")
            return nil
        }
    }
    
    func insert() -> CDNews? {
        
        var context = coreData.context
        
        let item = CDNews(context: context)
        return item
    }
    
    
}
