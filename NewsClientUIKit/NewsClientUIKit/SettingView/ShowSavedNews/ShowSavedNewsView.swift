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
    
    private var isDeleted = false
    private var deleteAllButton: UIBarButtonItem?
    
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
    
//    func configureNavBar() {
//        deleteAllButton = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(saveNews))
//        
//        navigationItem.rightBarButtonItem = deleteAllButton
//    }
//    
//    @objc func saveNews() {
//        
//        guard let news = savedNews
//        else { return }
//        
//        isSaved.toggle()
//        
//        let newImage = isSaved ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
//        saveButton?.image = newImage
//        print(isSaved ? "News saved" : "News doest saved")
//        
//        if isSaved {
//            //viewModel.saveNews(with: news)
//        } else {
//            viewModel.deleteNews(with: news.title)
//        }
//    }
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
