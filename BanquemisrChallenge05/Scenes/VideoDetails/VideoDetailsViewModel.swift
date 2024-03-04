//
//  VideoDetailsViewModel.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 02/03/2024.
//

import Foundation

protocol VideoDetailsVMProtocol: BaseViewModelProtocol {
    var video: VideoModel { get }
}

class VideoDetailsViewModel: BaseViewModel, VideoDetailsVMProtocol {
    
    var video: VideoModel
    var navigator: MainNavigatorProtocol?
    
    init(video: VideoModel) {
        self.video = video
    }
}
