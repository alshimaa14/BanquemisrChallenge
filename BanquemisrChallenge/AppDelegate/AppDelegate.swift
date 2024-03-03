//
//  AppDelegate.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 29/02/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        startApp()
        return true
    }
    
    func setRootViewController(_ viewController: UIViewController, animated: Bool = false) {
        
        guard animated else {
            window?.rootViewController = viewController
            return
        }
        let transition = UIView.AnimationOptions.transitionCrossDissolve
        window?.rootViewController = viewController
        UIView.transition(with: window!, duration: 0.5, options: transition, animations: {})
    }
}

private extension AppDelegate {
    func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
    }
         
    func startApp() {
        setRootViewController(TabBarController(), animated: false)
    }
}
