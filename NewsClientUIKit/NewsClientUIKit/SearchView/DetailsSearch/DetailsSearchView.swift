//
//  DetailsSearchView.swift
//  NewsClientUIKit
//
//  Created by Ruslan Liulka on 10.03.2025.
//

import UIKit
import SnapKit

class DetailsSearchView: UIViewController {
    
    let tableView = UITableView()
    var searchCategory: String?
    var request: SearchRequest?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let titleLabel = searchCategory else { return }
        
        title = titleLabel
        
        configureTableView()
        tableView.reloadData()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        //register cell
        tableView.register(NewsCell.self, forCellReuseIdentifier: "NewsCell")
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    
}

//MARK: - UITableViewDelegate
extension DetailsSearchView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    
}

//MARK: - UITableViewDataSource
extension DetailsSearchView: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(request?.totalResults)
        return request?.totalResults ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let unwrapedRequest = request else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
        print(indexPath.row)
        cell.set(news: unwrapedRequest.articles[indexPath.row])
       
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let mainRequest = request else { return }
        
        let detailsVC = DetailsNewsView()
        detailsVC.articles = mainRequest.articles[indexPath.row]
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    
}
