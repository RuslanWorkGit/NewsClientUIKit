//
//  DetailsSavedView.swift
//  NewsClientUIKit
//
//  Created by Ruslan Liulka on 13.03.2025.
//

import SnapKit
import UIKit
import SDWebImage

class DetailsSavedView: UIViewController {
    let image = UIImageView()
    let sourceNameLabel = UILabel()
    let authorLabel = UILabel()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let publishedAtLabel = UILabel()
    let content = UILabel()
    
    var savedNews: SavedArticles?
    private let viewModel = DetailsSavedViewModel()
    private var isSaved = false
    private var saveButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateUI()
        configureNavBar()
    }
    
    func setupUI() {
        view.addSubview(image)
        view.addSubview(sourceNameLabel)
        view.addSubview(authorLabel)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(publishedAtLabel)
        view.addSubview(content)
        
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        descriptionLabel.numberOfLines = 0
        content.numberOfLines = 0


        
        image.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
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
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(sourceNameLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(8)
            make.width.equalTo(view.bounds.width - 16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        content.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
    }
    
    func updateUI() {
        
        guard let news = savedNews else { return }
        
        sourceNameLabel.text = news.source.name
        authorLabel.text = "Author: \(news.author)"
        titleLabel.text = news.title
        descriptionLabel.text = news.description
        content.text = news.content
        
        guard let imageData = news.urlToImage else { return }
        image.image = UIImage(data: imageData)
    }
    
    func configureNavBar() {
        saveButton = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(saveNews))
        
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveNews() {
        
        guard let news = savedNews
        else { return }
        
        isSaved.toggle()
        
        let newImage = isSaved ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        saveButton?.image = newImage
        print(isSaved ? "News saved" : "News doest saved")
        
        if isSaved {
            //viewModel.saveNews(with: news)
        } else {
            viewModel.deleteNews(with: news.title)
        }
    }
    
}

