//
//  SearchView.swift
//  NewsClientUIKit
//
//  Created by Ruslan Liulka on 07.03.2025.
//
 
import UIKit
import SnapKit

class SearchView: UIViewController {
    
    let serchTextField = UITextField()
    let viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        
        view.addSubview(serchTextField)
        serchTextField.placeholder = "Search"
        serchTextField.borderStyle = .roundedRect
        
        serchTextField.snp.makeConstraints { make in
            
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(50)
            
        }
    }
}
