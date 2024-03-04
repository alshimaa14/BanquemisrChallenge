//
//  MainFacrtory.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 29/02/2024.
//

import UIKit

class MainFactory {
    
    static func home() -> UIViewController {
        let client = VideoClient()
        let repo = VideoRepo(client: client)
        let vm = VideosViewModel(repo: repo, videoType: .nowPlaying)
        let vc =  PlayingVideosViewController(viewModel: vm)
        vm.navigator = MainNavigator(vc)
        return MainNavigationController(rootViewController: vc)
    }
    
    static func popular() -> UIViewController {
        let client = VideoClient()
        let repo = VideoRepo(client: client)
        let vm = VideosViewModel(repo: repo, videoType: .popular)
        let vc =  PopularViewController(viewModel: vm)
        vm.navigator = MainNavigator(vc)
        return MainNavigationController(rootViewController: vc)
    }
    
    static func upcoming() -> UIViewController {
        let client = VideoClient()
        let repo = VideoRepo(client: client)
        let vm = VideosViewModel(repo: repo, videoType: .upcoming)
        let vc =  UpcomingViewController(viewModel: vm)
        vm.navigator = MainNavigator(vc)
        return MainNavigationController(rootViewController: vc)
    }
    
    static func videoDetails(video: VideoDataEntity) -> UIViewController {
        let vm = VideoDetailsViewModel(video: video)
        let vc = VideoDetailsViewController(viewModel: vm)
        vm.navigator = MainNavigator(vc)
        return vc
    }
    
}
