//
//  MainView.swift
//  NewsClientUIKit
//
//  Created by Ruslan Liulka on 07.03.2025.
//

import UIKit
import SnapKit


class MainView: UIViewController {
    
    private let newsTableView = NewsTableView<SavedArticles>()
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
    var savedArticles: [SavedArticles] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
    
        viewModel.fethcData(category: selectedCategory) { savedNews in
            self.savedArticles = savedNews
        }
        
        configureColectionView()
        configureTableView()
        
        loadNews()
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

        view.addSubview(newsTableView)
        
        newsTableView.cellConfigurator = { cell, article in
            if let newsCell = cell as? NewsCell {
                newsCell.set(news: article)
            }
        }
        
        newsTableView.didSelectedArticles = { [weak self] selectedArticle in
            guard let self = self else { return }

            let detailsVC = DetailsNews<SavedArticles>()
            detailsVC.news = selectedArticle
            navigationController?.pushViewController(detailsVC, animated: false)
        }
        
        newsTableView.snp.makeConstraints { make in
            make.top.equalTo(colectionView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(8)
            make.bottom.equalToSuperview()
        }
    }
    
    func loadNews() {
        viewModel.fethcData(category: selectedCategory) { savedNews in
            self.newsTableView.articles = savedNews
        }

    }
    
}

//MARK: - UICollectionViewDelegate
extension MainView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategory = Category.allCases[indexPath.item]
        
        loadNews()
        
        collectionView.reloadData()
    }
    
    
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

        return cell
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
                        url: self.url ?? "",
                        urlToImage: self.image,
                        publishedAt: self.publishTime ?? "",
                        content: self.content ?? "")
    }
}


