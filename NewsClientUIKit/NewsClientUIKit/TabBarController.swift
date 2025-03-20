//
//  TabBarController.swift
//  NewsClientUIKit
//
//  Created by Ruslan Liulka on 07.03.2025.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBar()
    }
    
    private func setupBar() {
        
        let mainVC = UINavigationController(rootViewController: MainView())
        let searchVC = UINavigationController(rootViewController: SearchView())
        let settingVC = UINavigationController(rootViewController: SettingView())
        
        mainVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        settingVC.tabBarItem = UITabBarItem(title: "Setting", image: UIImage(systemName: "gear"), tag: 2)
        
        viewControllers = [mainVC, searchVC, settingVC]
        
        tabBar.tintColor = .systemBlue
        tabBar.backgroundColor = .white
    }
}
