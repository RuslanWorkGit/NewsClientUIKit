//
//  CattegoryCell.swift
//  NewsClientUIKit
//
//  Created by Ruslan Liulka on 13.03.2025.
//

import UIKit
import SnapKit

class CategoryCell: UICollectionViewCell {
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    var didTapHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(categoryLabel)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didtapped))
        contentView.addGestureRecognizer(tapRecognizer)
        
        categoryLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.gray.cgColor
        
    }
    
    func configure(with category: String, isSelected: Bool) {
        categoryLabel.text = category
        contentView.backgroundColor = isSelected ? .blue : .white
        categoryLabel.textColor = isSelected ? .white : .black
    }
    
    @objc private func didtapped() {
        didTapHandler?()
    }
}
