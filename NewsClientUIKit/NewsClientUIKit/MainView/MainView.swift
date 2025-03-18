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
    private let colectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        let colletctionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        colletctionView.showsHorizontalScrollIndicator = false
        colletctionView.backgroundColor = .clear
        return colletctionView
    }()
    
    private var selectedCategory: Category = .general
    private let viewModel = MainViewModel()
    var request: NewsRequest?
    var savedArticles: [SavedArticles] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
    
        
        viewModel.fethcData(category: selectedCategory) { savedNews in
            self.savedArticles = savedNews
            
            self.tableView.reloadData()
        }
        
        setupBinding()
        configureColectionView()
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

    func configureColectionView() {
        view.addSubview(colectionView)
        
        colectionView.delegate = self
        colectionView.dataSource = self
        
        colectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        
        colectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(60)
        }
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        //register cell
        tableView.register(NewsCell.self, forCellReuseIdentifier: "NewsCell")
        
        tableView.separatorStyle = .none
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(colectionView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(8)
            make.bottom.equalToSuperview()
            
        }
    }
    
    
    
}

//MARK: - UITableViewDataSource
extension MainView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        return request?.articles.count ?? 0
        return savedArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //guard let newRequest = request else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
        cell.set(news: savedArticles[indexPath.row])
        return cell
    }
    
}

//MARK: - UITableViewDelegate
extension MainView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        guard let mainRequest = request else { return }
        
        let detailVC = DetailsNewsView()
        detailVC.savedArticles = savedArticles[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: false)
    }
}

//MARK: - UICollectionViewDelegate
extension MainView: UICollectionViewDelegate {
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        selectedCategory = Category.allCases[indexPath.item]
//        collectionView.reloadData()
////        viewModel.fethcData(category: selectedCategory)
//        
//        DispatchQueue.main.async {
//            self.savedArticles = self.viewModel.fetсhSavedData().map {$0.toArticle()}
//            self.tableView.reloadData()
//        }
//        
//        DispatchQueue.global(qos: .userInitiated).async {
//            self.viewModel.fethcData(category: self.selectedCategory) { savedNews in
//                DispatchQueue.main.async {
//                    self.savedArticles = savedNews
//                    self.tableView.reloadData()
//                }
//            }
//        }
//        viewModel.fethcData(category: selectedCategory) { savedNews in
//            self.savedArticles = savedNews
//        }
//        tableView.reloadData()
//    }
    
    
}

//MARK: - UICollectionViewDataSource
extension MainView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Category.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        
        let category = Category.allCases[indexPath.item]
        
        cell.configure(with: category.rawValue, isSelected: category == selectedCategory)
        
        cell.didTapHandler = { [weak self, category] in
            guard let self = self else { return }
            
            self.selectedCategory = category
            
            //viewModel.fethcData(category: <#T##Category#>, savedComletion: <#T##(([SavedArticles]) -> Void)##(([SavedArticles]) -> Void)##([SavedArticles]) -> Void#>)
            
            loadNews()
            }
        return cell
    }
    
    func loadNews() {
        viewModel.fethcData(category: selectedCategory) { savedNews in
            self.savedArticles = savedNews
            self.colectionView.reloadData()
            self.tableView.reloadData()
        }

    }

    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MainView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let category = Category.allCases[indexPath.item].rawValue
        let font = UIFont.systemFont(ofSize: 17)
        let width = category.size(withAttributes: [.font: font]).width + 20
        return CGSize(width: width, height: 40)
    }
}


extension CDNews {
    func toArticle() -> SavedArticles {
        return SavedArticles(source: Source(id: nil, name: self.name ?? "Unknown"),
                        author: self.author ?? "",
                        title: self.title ?? "",
                        description: self.descriptionLable ?? "",
                        url: "",
                        urlToImage: self.image,
                        publishedAt: self.publishTime ?? "",
                        content: self.content ?? "")
    }
}


