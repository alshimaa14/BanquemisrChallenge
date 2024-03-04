//
//  VideosVMProtocol.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 03/03/2024.
//

import Foundation
import Combine

protocol VideosVMProtocol: BaseViewModelProtocol {
    func getVideos()
    func getVideoItem(at indexPath: IndexPath) -> VideoModel?
    func navigateToVideoDetails(at indexPath: IndexPath)
    var videosPublisher: AnyPublisher<Bool, Never> { get }
    var numberOfVideosRows: Int { get }
}
