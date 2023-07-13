//
//  TabBarController.swift
//  InnovaCaseStudy
//
//  Created by Mert Çetin on 12.07.2023.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configure()
    }

    func configure() {
        self.tabBar.tintColor = .systemBlue
        self.tabBar.barStyle = .black
        self.tabBar.backgroundColor = .systemGray2.withAlphaComponent(0.7)
        self.tabBar.isTranslucent = true
        
        let HomeVCItem = HomeVC()
        let BudgetVCItem = BudgetVC()
        let ExchangeVCItem = ExchangeVC()
        let ProfileVCItem = ProfileVC()
        
        HomeVCItem.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        BudgetVCItem.tabBarItem = UITabBarItem(title: "Budget", image: UIImage(systemName: "plusminus.circle"), selectedImage: UIImage(systemName: "plusminus.circle.fill"))
        ExchangeVCItem.tabBarItem = UITabBarItem(title: "Exchange", image: UIImage(systemName: "dollarsign.circle"), selectedImage: UIImage(systemName: "dollarsign.circle.fill"))
        ProfileVCItem.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), selectedImage: UIImage(systemName: "person.crop.circle.fill"))
        
        let HomeVCNavController = UINavigationController(rootViewController: HomeVCItem)
        let BudgetVCNavController = UINavigationController(rootViewController: BudgetVCItem)
        let ExchangeVCNavController = UINavigationController(rootViewController: ExchangeVCItem)
        let ProfileVCNavController = UINavigationController(rootViewController: ProfileVCItem)
        
        viewControllers = [HomeVCNavController, BudgetVCNavController, ExchangeVCNavController, ProfileVCNavController]
    }
}
