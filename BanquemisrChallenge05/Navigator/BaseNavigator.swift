//
//  BaseNavigator.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 29/02/2024.
//

import UIKit

class BaseNavigator {
    private var navigationController: MainNavigationController? {
        return controller.navigationController as? MainNavigationController
    }

    let controller: UIViewController
    init(_ controller: UIViewController) {
        self.controller = controller
    }
}
