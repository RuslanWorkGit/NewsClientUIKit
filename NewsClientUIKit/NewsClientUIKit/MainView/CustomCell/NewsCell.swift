//
//  NewsCell.swift
//  NewsClientUIKit
//
//  Created by Ruslan Liulka on 07.03.2025.
//

import UIKit
import SnapKit
import SDWebImage


class NewsCell: UITableViewCell {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray.cgColor
        view.clipsToBounds = true
        return view
    }()
    
    var newsImageView = UIImageView()
    var newsTitleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(containerView)
        containerView.addSubview(newsImageView)
        containerView.addSubview(newsTitleLabel)
//        addSubview(newsImageView)
//        addSubview(newsTitleLabel)
        
        setupUI()
        configureImageView()
        configureTitleLabel()
        setContainerConstraint()
        setImageConstraint()
        setTitleConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = .clear
    }
    
    func set(news: Articles) {
        newsImageView.sd_setImage(with: URL(string: news.urlToImage ?? ""), placeholderImage: UIImage(named: "basicNews.jpg"))
        newsTitleLabel.text = news.title
        
        
    }
    
    func configureImageView() {
        newsImageView.layer.cornerRadius = 10
        newsImageView.clipsToBounds = true
        newsImageView.contentMode = .scaleAspectFill
        
    }
    
    func configureTitleLabel() {
        newsTitleLabel.numberOfLines = 0
        newsTitleLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func setContainerConstraint() {
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.bottom.equalToSuperview().offset(-4)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
    }
    
    func setImageConstraint() {
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        newsImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(12)
            make.height.equalTo(80)
            make.width.equalTo(newsImageView.snp.height).multipliedBy(16/9)
        }
    }
    
    func setTitleConstraint() {
        newsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        newsTitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(newsImageView.snp.trailing).offset(20)
            make.height.equalTo(80)
            make.trailing.equalToSuperview().offset(-12)
        }
    }
    
}
