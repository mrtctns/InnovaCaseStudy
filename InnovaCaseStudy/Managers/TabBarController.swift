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

       configure()
    }
    func configure(){
        self.tabBar.tintColor = .systemBlue
        self.tabBar.barStyle = .black
        self.tabBar.backgroundColor = .black.withAlphaComponent(0.8)
        self.tabBar.isTranslucent = true
        
        
        let HomeVCItem = HomeVC()
        
        HomeVCItem.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        let HomeVCNavigationController = UINavigationController(rootViewController: HomeVCItem)
        viewControllers = [HomeVCNavigationController]
        
    }


}
