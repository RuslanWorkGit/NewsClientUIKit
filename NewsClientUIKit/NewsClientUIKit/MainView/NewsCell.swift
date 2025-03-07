//
//  NewsCell.swift
//  NewsClientUIKit
//
//  Created by Ruslan Liulka on 07.03.2025.
//

import UIKit
import SnapKit

class NewsCell: UITableViewCell {
    
    var newsImageView = UIImageView()
    var newsTitleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(newsImageView)
        addSubview(newsTitleLabel)
        
        configureImageView()
        configureTitleLabel()
        setImageConstraint()
        setTitleConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(news: NewsRequest) {
        newsTitleLabel.text = news.articles[0].title
    }
    
    func configureImageView() {
        newsImageView.layer.cornerRadius = 10
        newsImageView.clipsToBounds = true
        
    }
    
    func configureTitleLabel() {
        newsTitleLabel.numberOfLines = 0
        newsTitleLabel.adjustsFontSizeToFitWidth = true
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
