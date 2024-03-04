//
//  VideoDetailsViewModel.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 02/03/2024.
//

import Foundation

protocol VideoDetailsVMProtocol: BaseViewModelProtocol {
    var video: VideoDataEntity { get }
}

class VideoDetailsViewModel: BaseViewModel, VideoDetailsVMProtocol {
    
    var video: VideoDataEntity
    var navigator: MainNavigatorProtocol?
    
    init(video: VideoDataEntity) {
        self.video = video
    }
}
