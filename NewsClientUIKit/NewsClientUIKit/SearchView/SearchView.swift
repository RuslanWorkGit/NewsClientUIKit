//
//  SearchView.swift
//  NewsClientUIKit
//
//  Created by Ruslan Liulka on 07.03.2025.
//
 
import UIKit
import SnapKit

class SearchView: UIViewController {
    
    let searchTextField = UITextField()
    let searchButton = UIButton()
    let switchPopularity = UISwitch()
    
    var request: SearchRequest?
    let viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupAction()
        setupBinding()
    }
    
    func setupUI() {
        
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        view.addSubview(switchPopularity)
        
        searchTextField.placeholder = "Search"
        searchTextField.borderStyle = .roundedRect
        
        searchButton.setTitle("Search", for: .normal)
        searchButton.tintColor = .white
        searchButton.layer.cornerRadius = 10
        searchButton.layer.borderWidth = 2
        searchButton.backgroundColor = .lightGray
        
        
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(50)
        }
        
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(24)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        
        switchPopularity.snp.makeConstraints { make in
            make.top.equalTo(searchButton.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(24)
        }
    }
    
    func setupBinding() {
        viewModel.updateRequest = { [weak self] result in
            DispatchQueue.main.async {
                self?.request = result
            }
            
        }
    }
    
    func setupAction() {
        searchButton.addTarget(self, action: #selector(searctAction), for: .touchUpInside)
    }
    
    @objc func searctAction() {
        
        guard let search = searchTextField.text, !search.isEmpty else {
            assertionFailure("TextDield is empty!!!")
            return
        }
        
        if switchPopularity.isOn {
            
        }
        viewModel.fetchSearchData(with: search, sortByPopularity: true) { [weak self] request in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                let searchVC = DetailsSearchView()
                searchVC.searchCategory = search
                searchVC.request = request
                self.navigationController?.pushViewController(searchVC, animated: true)
            }
        }
        
    }
}
