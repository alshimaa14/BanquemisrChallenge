//
//  VideoTableViewCell.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 29/02/2024.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var videoNameLabel: UILabel!
    @IBOutlet private weak var releasedDateLabel: UILabel!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var detailsView: UIView!
    
    var videoModel: VideoModel? {
        didSet {
            guard let model = videoModel else { return }
            configure(with: model)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        setupViewUI()
    }
    
    private func setupViewUI() {
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
        detailsView.backgroundColor = UIColor.black.withAlphaComponent(0.5)

    }
    
    private func configure(with model: VideoModel) {
        let path = Constants.url + model.posterPath
        posterImageView.load(imageUrl: path)
        videoNameLabel.text = model.title
        releasedDateLabel.text = model.releaseDate
    }
}
