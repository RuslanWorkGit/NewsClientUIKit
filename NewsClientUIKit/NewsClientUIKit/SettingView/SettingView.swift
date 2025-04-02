//
//  SettingView.swift
//  NewsClientUIKit
//
//  Created by Ruslan Liulka on 07.03.2025.
//

import UIKit
import SnapKit

protocol SettingViewDelegate: AnyObject {
    func didClearCache()
}

class SettingView: UIViewController {
    
    let showSavedButton = UIButton()
    let cleanCacheButton = UIButton()
    private var savedNews: [SavedArticles] = []
    private let viewModel = SettingViewModel()
    
    weak var delegate: SettingViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Setting"
        setupUI()
        setupAction()
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground

        view.addSubview(showSavedButton)
        view.addSubview(cleanCacheButton)
        
        showSavedButton.setTitle("Show Saved News", for: .normal)
        showSavedButton.setTitleColor(.black, for: .normal)
        showSavedButton.layer.cornerRadius = 10
        showSavedButton.layer.borderWidth = 1
        showSavedButton.backgroundColor = .white
        
        cleanCacheButton.setTitle("Clean Cache", for: .normal)
        cleanCacheButton.setTitleColor(.black, for: .normal)
        cleanCacheButton.layer.cornerRadius = 10
        cleanCacheButton.layer.borderWidth = 1
        cleanCacheButton.backgroundColor = .white

        showSavedButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.leading.trailing.equalToSuperview().inset(24)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        
        cleanCacheButton.snp.makeConstraints { make in
            make.top.equalTo(showSavedButton.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(24)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        
    }
    
    func setupAction() {
        showSavedButton.addTarget(self, action: #selector(showSavedNews), for: .touchUpInside)
        cleanCacheButton.addTarget(self, action: #selector(cleanCacheNews), for: .touchUpInside)
    }
    
    @objc func showSavedNews() {
        
        let showListSavedNews = ShowSavedNewsView()
        showListSavedNews.savedNews = viewModel.funcLoadData()
        navigationController?.pushViewController(showListSavedNews, animated: true)
    }
    
    @objc func cleanCacheNews() {
        viewModel.cleanCache()
        
        delegate?.didClearCache()
        
        let alert = UIAlertController(title: "Cache", message: "News cache cleared succesfully", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alert, animated: true)
    }
    
    
}
