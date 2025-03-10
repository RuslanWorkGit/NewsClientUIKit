//
//  MainView.swift
//  NewsClientUIKit
//
//  Created by Ruslan Liulka on 07.03.2025.
//

import UIKit
import SnapKit


class MainView: UIViewController {
    
    let tableView = UITableView()
    
    private let viewModel = MainViewModel()
    var request: NewsRequest?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        viewModel.fethcData { result in
//            self.request = result
//            self.tableView.reloadData()
//        }
        
        title = "Home"
        viewModel.fethcData()
        setupBinding()
        configureTableView()
    }
    
    func setupBinding() {
        viewModel.updateNews = { [weak self] requestResult in
            DispatchQueue.main.async {
                self?.request = requestResult
                self?.tableView.reloadData()
            }
        }
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

//MARK: - UITableViewDataSource
extension MainView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return request?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let newRequest = request else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
        cell.set(news: newRequest.articles[indexPath.row])
        return cell
    }
    
    
    
    
}

//MARK: - UITableViewDelegate
extension MainView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let mainRequest = request else { return }
        
        let detailVC = DetailsNewsView()
        detailVC.articles = mainRequest.articles[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: false)
    }
}


