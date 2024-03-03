//
//  UIViewController.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 01/03/2024.
//

import UIKit

extension UIViewController {
    func showAlert(with message: String) {
        AlertBuilder(title: "Banquemisr", message: message, preferredStyle: .alert)
            .addAction(title: NSLocalizedString("Ok", comment: ""), style: .default)
            .build()
            .show()
    }
    
    func showPopableAlert(with message: String, completionHandeler: @escaping ()-> Void) {
        AlertBuilder(title: "Banquemisr", message: message, preferredStyle: .alert)
            .addAction(title: NSLocalizedString("Ok", comment: ""), style: .default, handler: {
                completionHandeler()
            })
            .build()
            .show()
    }
    
    func push(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}
