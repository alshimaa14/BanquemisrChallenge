//
//  UIView.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 01/03/2024.
//

import UIKit

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

