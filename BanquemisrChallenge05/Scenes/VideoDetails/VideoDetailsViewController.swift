//
//  VideoDetailsViewController.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 01/03/2024.
//

import UIKit

class VideoDetailsViewController: BaseViewController {
    
    let viewModel: VideoDetailsViewModel
    
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var lastReleaseLabel: UILabel!
    @IBOutlet private weak var detailsLabel: UILabel!
    
    init(viewModel: VideoDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: VideoDetailsViewController.className, bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.baseViewModel = viewModel
        super.viewDidLoad()
        setViewData()
    }

}

extension VideoDetailsViewController {
    private func setViewData() {
        let path = Constants.url + viewModel.video.posterPath
        posterImageView.load(url: path)
        title = viewModel.video.title
        titleLabel.text = viewModel.video.title
        lastReleaseLabel.text = viewModel.video.releaseDate
        detailsLabel.text = viewModel.video.overview
    }
}
