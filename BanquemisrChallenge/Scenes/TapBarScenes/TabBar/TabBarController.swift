//
//  TabBarController.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 01/03/2024.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupTabBar() {
        viewControllers = createTabBarController()
        setupTabBarItem()
        setupAppearance()
    }
    
    func setupAppearance() {
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.barTintColor = UIColor.systemGray5
        tabBarAppearance.tintColor = .black
        
        tabBar.isTranslucent = false
        tabBar.clipsToBounds = false
        tabBar.layer.masksToBounds = true
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
    }
    
    func setupTabBarItem() {
        tabBar.items?[0].image = UIImage(named: "playing")
        tabBar.items?[0].title = "Now Playing Movies"
        
        tabBar.items?[1].image = UIImage(named: "popular")
        tabBar.items?[1].title = "Popular Movies"
        
        tabBar.items?[2].image = UIImage(named: "upcoming")
        tabBar.items?[2].title = "Upcoming Movies"

        tabBar.items?.forEach({
            $0.imageInsets = UIEdgeInsets(top: 3, left: 0, bottom: 0, right: 0)
            $0.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
        })
    }
            
    private func createTabBarController() -> [UIViewController] {
        let tabBarControllers: [UIViewController] =
        [MainFactory.home(),
         MainFactory.popular(),
         MainFactory.upcoming(),
        ]
        return tabBarControllers
    }
}

