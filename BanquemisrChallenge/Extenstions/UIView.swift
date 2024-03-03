//
//  UIView.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 01/03/2024.
//

import MBProgressHUD
import UIKit

extension UIView {

    func showActivityIndicator(isUserInteractionEnabled: Bool) {
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.isUserInteractionEnabled = !isUserInteractionEnabled
        hud.restorationIdentifier = "activityIndicator"
    }

    func hideActivityIndicator() {
        for subview in subviews where subview.restorationIdentifier == "activityIndicator" {
            guard let hud = subview as? MBProgressHUD else { return }
            hud.hide(animated: true)
        }
    }

}

@IBDesignable
extension UIView {
    @IBInspectable var cornerRadious: CGFloat {
        get {
            layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}

