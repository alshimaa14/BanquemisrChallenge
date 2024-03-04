//
//  VideoClient.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 02/03/2024.
//

import Foundation

protocol VideoClientType {
    func getVideos(videoType: VideoTypeURL) async throws -> VideosResponse
}

class VideoClient: VideoClientType {
    
    private let client = NetworkClient()
    
    func getVideos(videoType: VideoTypeURL) async throws -> VideosResponse {
        let request = URLRequestBuilder(path: videoType.getTypeBath)
        return try await client.sendRequest(request)
    }
    
}
