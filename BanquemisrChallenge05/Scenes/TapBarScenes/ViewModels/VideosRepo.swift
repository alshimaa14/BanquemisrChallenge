//
//  PlayingVideosRepo.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 02/03/2024.
//

import Foundation

protocol VideoRepoProtocol {
    func getVideoDataModel(videoType: VideoTypeURL) async throws -> [VideoDataEntity]
}

class VideoRepo: VideoRepoProtocol {
    private let client: VideoClientType
    
    init(client: VideoClientType) {
        self.client = client
    }
    
    func getVideoDataModel(videoType: VideoTypeURL) async throws -> [VideoDataEntity] {
        let response = try await client.getVideos(videoType: videoType)
        let videoModel = response.results?.map({ VideoDataEntity(response: $0) }) ?? []
        return videoModel
    }
}
