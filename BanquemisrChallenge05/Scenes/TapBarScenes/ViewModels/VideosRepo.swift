//
//  PlayingVideosRepo.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 02/03/2024.
//

import Foundation

protocol VideoRepoProtocol {
    func getVideoDataModel(with page: Int) async throws -> VideosEntity
}

class VideoRepo: VideoRepoProtocol {
    private let client: VideoClientType
    
    init(client: VideoClientType) {
        self.client = client
    }
    
    func getVideoDataModel(with page: Int) async throws -> VideosEntity {
        let response = try await client.getVideos(with: page)
        let videos = response.mapToVideosEntity()
        return videos
    }
}
