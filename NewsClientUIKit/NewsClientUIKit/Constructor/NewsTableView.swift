//
//  NewsTableView.swift
//  NewsClientUIKit
//
//  Created by Ruslan Liulka on 19.03.2025.
//

import UIKit

class NewsTableView<T>: UIView, UITableViewDataSource, UITableViewDelegate {
    
    let tableView = UITableView()
    
    var articles: [T] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    //налаштування ячейки
    var cellConfigurator: ((UITableViewCell, T) -> Void)?
    
//    var didSelectedArticles: ((SavedArticles) -> Void)?
    var didSelectedArticles: ((T) -> Void)?
    
    var deletionHandler: ((Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTableView()
    }
    
    private func setupTableView() {
        addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsCell.self, forCellReuseIdentifier: "NewsCell")
        tableView.separatorStyle = .none
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        let item = articles[indexPath.row]
        cellConfigurator?(cell, item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        guard let deletionHandler = deletionHandler else { return nil}
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
            
            deletionHandler(indexPath.row)
            
            completionHandler(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        didSelectedArticles?(article)
    }
}


