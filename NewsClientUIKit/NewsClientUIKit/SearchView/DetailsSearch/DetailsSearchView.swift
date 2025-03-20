//
//  DetailsSearchView.swift
//  NewsClientUIKit
//
//  Created by Ruslan Liulka on 10.03.2025.
//

import UIKit
import SnapKit

class DetailsSearchView: UIViewController {
    
    let newsTableView = NewsTableView<Articles>()
    var searchCategory: String?
    var request: SearchRequest?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let titleLabel = searchCategory else { return }
        
        title = titleLabel
        
        configureTableView()
    }
    
    func configureTableView() {
        view.addSubview(newsTableView)
        
        if let articles = request?.articles {
            newsTableView.articles = articles
        }
        
        newsTableView.cellConfigurator = { cell, article in
            if let newsCell = cell as? NewsCell {
                newsCell.set(news: article)
            }
        }
        
        newsTableView.didSelectedArticles = { [weak self] article in
            guard let self = self else { return }
            
            let detailsVC = DetailsNews<Articles>()
            detailsVC.news = article
            self.navigationController?.pushViewController(detailsVC, animated: false)
        }
        
        newsTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
}

