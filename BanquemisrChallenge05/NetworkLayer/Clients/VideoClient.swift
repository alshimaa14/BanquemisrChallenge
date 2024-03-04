//
//  VideoClient.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 02/03/2024.
//

import Foundation

protocol VideoClientType {
    func getVideos() async throws -> VideosResponse
}

struct VideoClient: VideoClientType {
    
    private let client = NetworkClient()
    private let videoType: VideoTypeURL
    
    init(videoType: VideoTypeURL) {
        self.videoType = videoType
    }
    
    func getVideos() async throws -> VideosResponse {
        let request = URLRequestBuilder(path: videoType.getTypeBath)
        return try await client.sendRequest(request)
    }
    
}
