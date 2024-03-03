//
//  UIImageViewExtension.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 02/03/2024.
//

import Foundation
import Kingfisher
import UIKit

extension UIImageView {

    func load(imageUrl: String?, placeholder: UIImage? = UIImage(named: "place-holderv2")) {
        guard let url = imageUrl, let path = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed) else {
            print("Error in Image Link ")
            return
        }
        let imgurl = URL(string: path)
        var kf = self.kf
        kf.indicatorType = .activity
        kf.setImage(with: imgurl, placeholder: placeholder)
    }
    
}
