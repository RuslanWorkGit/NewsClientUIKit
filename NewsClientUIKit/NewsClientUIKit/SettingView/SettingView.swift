//
//  SettingView.swift
//  NewsClientUIKit
//
//  Created by Ruslan Liulka on 07.03.2025.
//

import UIKit
import SnapKit

class SettingView: UIViewController {
    
    let showSavedButton = UIButton()
    private var savedNews: [SavedArticles] = []
    private let viewModel = SettingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Setting"
        setupUI()
        setupAction()
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground

        view.addSubview(showSavedButton)
        
        showSavedButton.setTitle("Show Saved News", for: .normal)
        showSavedButton.setTitleColor(.black, for: .normal)
        showSavedButton.layer.cornerRadius = 10
        showSavedButton.layer.borderWidth = 1
        showSavedButton.backgroundColor = .white

        showSavedButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.leading.trailing.equalToSuperview().inset(24)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        
    }
    
    func setupAction() {
        showSavedButton.addTarget(self, action: #selector(showSavedNews), for: .touchUpInside)
    }
    
    @objc func showSavedNews() {
        
        let showListSavedNews = ShowSavedNewsView()
        showListSavedNews.savedNews = viewModel.funcLoadData()
        navigationController?.pushViewController(showListSavedNews, animated: true)
    }
    
    
}
