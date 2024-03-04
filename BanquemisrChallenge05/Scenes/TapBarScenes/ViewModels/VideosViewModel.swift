//
//  HomeViewModel.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 01/03/2024.
//

import Foundation
import Combine

class VideosViewModel: BaseViewModel {
    
    @Published private var videos: [VideoDataEntity]?
    var navigator: MainNavigatorProtocol?
    private let repo: VideoRepoProtocol
    
    init(repo: VideoRepoProtocol) {
        self.repo = repo
    }
    
}

extension VideosViewModel: VideosVMProtocol {
    
    var numberOfVideosRows: Int {
        return videos?.count ?? 0
    }
    
    var videosPublisher: AnyPublisher<Bool, Never> {
        $videos.compactMap({$0?.isEmpty})
            .eraseToAnyPublisher()
    }
    
    func getVideoItem(at indexPath: IndexPath) -> VideoDataEntity? {
        return videos?[indexPath.item]
    }
    
    func navigateToVideoDetails(at indexPath: IndexPath) {
        guard let passedVideo = videos?[indexPath.row] else { return }
        navigator?.navigateTo(destination: .details(passedVideo))
    }
    
    func getVideos() {
        Task {
            do {
                indicator = .loading(userInterAction: false, hideView: false)
                let data = try await repo.getVideoDataModel()
                self.videos = data
                indicator = .loaded
            } catch {
                self.didFetchError(error)
            }
        }
    }
}

