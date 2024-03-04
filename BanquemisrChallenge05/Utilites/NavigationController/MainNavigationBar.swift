//
//  MainNavigationBar.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 29/02/2024.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }

    private func setupNavigationBar() {
        navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black,
        ]

        navigationBar.prefersLargeTitles = false
        navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.black,
        ]

        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.tintColor = .black
        navigationBar.barTintColor = .black
        navigationBar.layer.masksToBounds = false
        navigationBar.layer.applySketchShadow(color: .black.withAlphaComponent(0.19), alpha: 1.0, x: 0, y: 0, blur: 3, spread: 0)
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.titleTextAttributes = [
                .foregroundColor: UIColor.black,
            ]

            appearance.largeTitleTextAttributes = [
                .foregroundColor: UIColor.black,
            ]
            
            appearance.shadowImage = UIColor.black.withAlphaComponent(0.19).as1ptImage()

            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        }
    }
}


extension UIColor {
    func as1ptImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSizeMake(1, 1))
        let context = UIGraphicsGetCurrentContext()
        self.setFill()
        context!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }
}
