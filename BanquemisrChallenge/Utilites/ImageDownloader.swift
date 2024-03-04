//
//  ImageDownloader.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 01/03/2024.
//

import UIKit

typealias DownloadImageHandler = (UIImage?) -> Void

protocol ImageDownloading {
    func downloadImageWith(url: URL, completion: DownloadImageHandler?)
}

final class ImageDownloader: ImageDownloading {
    func downloadImageWith(url: URL, completion: DownloadImageHandler?) {
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data,
                let image = UIImage(data: data) else {
                completion?(nil)
                return
            }
            completion?(image)
        }
        dataTask.resume()
    }
}
