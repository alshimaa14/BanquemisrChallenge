//
//  UIImageViewExtension.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 02/03/2024.
//

import Foundation
import UIKit

extension UIImageView {
    
    func setImage(forURL url: URL?) {
        guard let url = url else {
            return
        }
        ImageDownloader().downloadImageWith(url: url) { [weak self] _image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.image = _image
            }
        }
    }
    
    func setImage(forURL url: String?) {
        guard let path = url, let _url = URL(string: path) else {
            return
        }
        self.setImage(forURL: _url)
    }
}

fileprivate var cache = [URL: Data]()

extension UIImageView {
    func load(url: String) {
        guard let url = URL(string: url) else { return }
        DispatchQueue.global().async {
            if let cachedImageData = cache[url] {
                if let image = UIImage(data: cachedImageData) {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            } else {
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            cache[url] = data
                            self.image = image
                        }
                    }
                }
            }
        }
    }
}
