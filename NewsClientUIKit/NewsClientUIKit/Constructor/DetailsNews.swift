//
//  DetailsNews.swift
//  NewsClientUIKit
//
//  Created by Ruslan Liulka on 20.03.2025.
//

import UIKit
import SnapKit

class DetailsNews<T: NewsRepresentable>: UIViewController {
    
    let titleLabel = UILabel()
    let image = UIImageView()
    let sourceNameLabel = UILabel()
    let authorLabel = UILabel()
    let descriptionLabel = UILabel()
    let publishedAtLabel = UILabel()
    let contentLabel = UILabel()
    
    var news: T?
    
    private let viewModel = NewDetailsNewsViewModel()
    private var isSaved = false
    private var saveButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupUI()
        updateUI()
        configureNavBar()
    }
    
    
    func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(image)
        view.addSubview(sourceNameLabel)
        view.addSubview(authorLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(publishedAtLabel)
        view.addSubview(contentLabel)
        
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        descriptionLabel.numberOfLines = 0
        contentLabel.numberOfLines = 0
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.leading.equalToSuperview().inset(16)
            
        }
        
        image.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.trailing.leading.equalToSuperview()
            make.height.equalTo(250)
        }
        
        sourceNameLabel.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(8)
            make.width.equalTo(view.bounds.width / 2)
        }
                
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(16)
            make.trailing.equalToSuperview().offset(-8)
            make.width.equalTo(view.bounds.width / 2)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(sourceNameLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(8)
        }
    }
    
    func updateUI() {
        
        guard let news = news else { return }
        
        titleLabel.text = news.newsTitle
        sourceNameLabel.text = news.newsSourceName
        authorLabel.text = news.newsAuthor
        descriptionLabel.text = news.newsDescriptionText
        contentLabel.text = news.newsContent
        
        guard let imageData = news.newsImageData else {
            image.image = UIImage(named: "basicNews.jpg")
            return
        }
        
        image.image = UIImage(data: imageData)
        
    }
    
    func configureNavBar() {
        guard let news = news else { return }
        
        print(news.newsUrl)
        
        guard let isNewsExists = viewModel.isElementExists(with: news.newsUrl) else { return }
        isSaved = isNewsExists
        
        if isSaved {
            saveButton = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(deleteNews))
        } else {
            saveButton = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(saveNews))
        }

        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveNews() {
        
        guard let news = news else { return }
        viewModel.save(with: news)
        configureNavBar()
    }
    
    @objc func deleteNews() {
        guard let news = news else { return }
        
        viewModel.delete(with: news.newsUrl)
        isSaved = false
        configureNavBar()

    }
    
}
