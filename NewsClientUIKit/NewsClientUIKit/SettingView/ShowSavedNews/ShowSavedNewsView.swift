//
//  ShowSavedNewsView.swift
//  NewsClientUIKit
//
//  Created by Ruslan Liulka on 13.03.2025.
//
import UIKit
import SnapKit

class ShowSavedNewsView: UIViewController {
    
    let tableView = UITableView()
    var savedNews: [SavedNews] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(SavedNewsCell.self, forCellReuseIdentifier: "SavedNewsCell")
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

//MARK: - UITableViewDelegate
extension ShowSavedNewsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = DetailsSavedView()
        detailsVC.savedNews = savedNews[indexPath.row]
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    
}

//MARK: - UITableViewDataSource
extension ShowSavedNewsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        savedNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedNewsCell") as! SavedNewsCell
        cell.set(news: savedNews[indexPath.row])
        return cell
    }
    
    
}
