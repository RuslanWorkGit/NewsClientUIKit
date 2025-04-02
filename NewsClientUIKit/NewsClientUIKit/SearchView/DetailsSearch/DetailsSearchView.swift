//
//  DetailsSearchView.swift
//  NewsClientUIKit
//
//  Created by Ruslan Liulka on 10.03.2025.
//

import UIKit
import SnapKit

class DetailsSearchView: UIViewController {
    
//    let newsTableView = NewsTableView<Articles>()
    let tableView = UITableView()
    var searchCategory: String?
    var request: SearchRequest?
    
    var currentPage = 1
    var isLoadingMore = false
    var viewModel = DetailsSearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let titleLabel = searchCategory else { return }
        title = titleLabel
        
        configureTableView()
//        loadingInitialData()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(NewsCell.self, forCellReuseIdentifier: "NewsCell")
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    func loadMoreData() {
        guard let searchQuery = searchCategory, !isLoadingMore else { return }
        isLoadingMore = true
        currentPage += 1
        
        viewModel.aditionalSearch(searchString: searchQuery, page: currentPage) { results in
            if var myRequest = self.request {
                myRequest.articles.append(contentsOf: results.articles)
                self.request = myRequest
                self.tableView.reloadData()
            }
            
            self.isLoadingMore = false
        }
    }
    
}

extension DetailsSearchView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return request?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
        
        if let article = request?.articles[indexPath.row] {
            cell.set(news: article)
        }
       
        print(indexPath.row)
        
        return cell
    }
    
    
}

extension DetailsSearchView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = DetailsNews<Articles>()
        guard let article = request?.articles[indexPath.row] else { return }
        detailsVC.news = article
        self.navigationController?.pushViewController(detailsVC, animated: false)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let articleCount = request?.articles.count else { return }
        
        if indexPath.row == articleCount - 1 {
            loadMoreData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

