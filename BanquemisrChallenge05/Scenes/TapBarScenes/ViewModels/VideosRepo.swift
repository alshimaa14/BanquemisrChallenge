//
//  PlayingVideosRepo.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 02/03/2024.
//

import Foundation

protocol VideoRepoProtocol {
    func getVideoDataModel() async throws -> [VideoDataEntity]
}

class VideoRepo: VideoRepoProtocol {
    private let client: VideoClientType
    
    init(client: VideoClientType) {
        self.client = client
    }
    
    func getVideoDataModel() async throws -> [VideoDataEntity] {
        let response = try await client.getVideos()
        let videos = response.mapToVideosEntity()
        return videos.results
    }
}
