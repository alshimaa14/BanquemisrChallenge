//
//  VideosVMProtocol.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 03/03/2024.
//

import Foundation
import Combine

protocol VideosVMProtocol: BaseViewModelProtocol {
    var videosPublisher: AnyPublisher<Bool, Never> { get }
    var numberOfVideosRows: Int { get }
    func getVideos()
    func getVideoItem(at indexPath: IndexPath) -> VideoDataEntity?
    func navigateToVideoDetails(at indexPath: IndexPath)
    func loadNextPage() 
}
