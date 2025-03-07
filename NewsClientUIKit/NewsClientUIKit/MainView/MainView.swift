//
//  MainView.swift
//  NewsClientUIKit
//
//  Created by Ruslan Liulka on 07.03.2025.
//

import UIKit
import SnapKit

class MainView: UIViewController {
    
    private let viewModel = MainViewModel()
    var request: NewsRequest?
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fethcData { result in
            self.request = result
            self.tableView.reloadData()
        }
        
        configureTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //tableView.frame = view.bounds
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
        
        tableView.reloadData()
    }
    
}

//MARK: - UITableViewDataSource
extension MainView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return request?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
        //cell.newsTitleLabel.text = "Hello"
        cell.set(news: request!)
        //cell.newsTitleLabel.text = request?.articles[indexPath.row].title
        return cell
    }
    
    
}

//MARK: - UITableViewDelegate
extension MainView: UITableViewDelegate {
    
}


