//
//  MainNavigator.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 29/02/2024.
//

import UIKit

enum MainDestination {
    case details(VideoModel)
}

protocol MainNavigatorProtocol {
    func navigateTo(destination: MainDestination)
}

class MainNavigator: BaseNavigator, MainNavigatorProtocol {
    func navigateTo(destination: MainDestination) {
        switch destination {
        case .details(let video):
            controller.push(MainFactory.videoDetails(video: video))
        }
    }
}
