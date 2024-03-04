//
//  VideoTypeURL.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 02/03/2024.
//

import Foundation

enum VideoTypeURL {
    case nowPlaying
    case popular
    case upcoming
    
    var getTypeBath: String {
        switch self {
        case .nowPlaying:
            return "now_playing"
        case .popular:
            return "popular"
        case .upcoming:
            return "upcoming"
        }
    }
}
