//
//  HomeViewModel.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 01/03/2024.
//

import Foundation
import Combine

class VideosViewModel: BaseViewModel {
    
    @Published private var videosEntity: [VideoDataEntity]?
    private var currentPage: Int = 1
    private var totalPages:Int = 1
    private var videosList: [VideoDataEntity] = []
    var navigator: MainNavigatorProtocol?
    private let repo: VideoRepoProtocol
    
    init(repo: VideoRepoProtocol) {
        self.repo = repo
    }
    
}

extension VideosViewModel: VideosVMProtocol {
    
    var numberOfVideosRows: Int {
        return videosEntity?.count ?? 0
    }
    
    var videosPublisher: AnyPublisher<Bool, Never> {
        $videosEntity.compactMap({$0?.isEmpty})
            .eraseToAnyPublisher()
    }
    
    func getVideoItem(at indexPath: IndexPath) -> VideoDataEntity? {
        return videosEntity?[indexPath.item]
    }
    
    func navigateToVideoDetails(at indexPath: IndexPath) {
        guard let passedVideo = videosEntity?[indexPath.row] else { return }
        navigator?.navigateTo(destination: .details(passedVideo))
    }
    
    func loadNextPage() {
        if currentPage < totalPages {
            currentPage += 1
            getVideos()
        }
    }
    
    func getVideos() {
        Task {
            do {
                indicator = .loading(userInterAction: false, hideView: false)
                let response = try await repo.getVideoDataModel(with: currentPage)
                totalPages = response.totalPages
                videosList.append(contentsOf: response.results)
                videosEntity = videosList
                indicator = .loaded
            } catch {
                self.didFetchError(error)
            }
        }
    }
}

