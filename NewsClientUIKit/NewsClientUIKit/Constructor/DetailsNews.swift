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
    let readMoreButton = UIButton()
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    var news: T?
    
    private let viewModel = NewDetailsNewsViewModel()
    private var isSaved = false
    private var saveButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupUI()
        updateUI()
        configureNavBar()
        configureReadButton()
    }
    
    
    func setupUI() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(image)
        contentView.addSubview(sourceNameLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(publishedAtLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(readMoreButton)
        
   
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        descriptionLabel.numberOfLines = 0
        contentLabel.numberOfLines = 0
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(16)
            make.trailing.leading.equalTo(contentView).inset(16)
            
        }
        
        image.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.trailing.leading.equalTo(contentView)
            make.height.equalTo(250)
        }
        
        sourceNameLabel.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(16)
            make.leading.equalTo(contentView).offset(8)
            make.width.equalTo(view.bounds.width / 2)
        }
                
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(16)
            make.trailing.equalTo(contentView).offset(-8)
            make.width.equalTo(view.bounds.width / 2)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(sourceNameLabel.snp.bottom).offset(16)
            make.leading.trailing.equalTo(contentView).inset(8)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            make.leading.trailing.equalTo(contentView).inset(8)
        }
        
        readMoreButton.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(16)
            make.leading.trailing.equalTo(contentView).inset(8)
            make.height.equalTo(50)
            make.bottom.equalTo(contentView).offset(-16)
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
        
        readMoreButton.setTitle("Read More", for: .normal)
        readMoreButton.setTitleColor(.black, for: .normal)
        readMoreButton.layer.cornerRadius = 10
        readMoreButton.layer.borderWidth = 1
        readMoreButton.layer.borderColor = UIColor.black.cgColor
        
        
    }
    
    func configureNavBar() {
        guard let news = news else { return }
        
        guard let isNewsExists = viewModel.isElementExists(with: news.newsUrl) else { return }
        isSaved = isNewsExists
        
        if isSaved {
            saveButton = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(deleteNews))
        } else {
            saveButton = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(saveNews))
        }

        navigationItem.rightBarButtonItem = saveButton
    }
    
    func configureReadButton() {
        readMoreButton.addTarget(self, action: #selector(readMoreSafari), for: .touchUpInside)
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
    
    @objc func readMoreSafari() {
        guard let stringUrl = news?.newsUrl else { return }
        
        if let url = URL(string: stringUrl) {
            UIApplication.shared.open(url)
        } else {
            print("Wrong link!!")
        }
        
    }
    
}
