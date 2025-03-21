//
//  ShowSavedNewsView.swift
//  NewsClientUIKit
//
//  Created by Ruslan Liulka on 13.03.2025.
//
import UIKit
import SnapKit

class ShowSavedNewsView: UIViewController {
    
    var savedNews: [SavedArticles] = []
    
    let savedTableView = NewsTableView<SavedArticles>()
    private var viewModel = ShowSavedNewsViewModel()
    private var isDeleted = false
    private var deleteAllButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureNavBar()
    }
    
    func configureTableView() {
        view.addSubview(savedTableView)
        
        savedTableView.articles = savedNews
        
        savedTableView.cellConfigurator = { cell, articel in
            if let newsCell = cell as? NewsCell {
                newsCell.set(news: articel)
            }
        }
        
        savedTableView.didSelectedArticles = { [weak self] selectedArticle in
            
            guard let self = self else { return }
            
            let detailsVC = DetailsNews<SavedArticles>()
            detailsVC.news = selectedArticle
            navigationController?.pushViewController(detailsVC, animated: false)
            
        }
        
        savedTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureNavBar() {
        deleteAllButton = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteNews))
        
        navigationItem.rightBarButtonItem = deleteAllButton
    }
    
    @objc func deleteNews() {
        viewModel.deleteAll()
    }
}
