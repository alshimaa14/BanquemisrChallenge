//
//  VideoClient.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 02/03/2024.
//

import Foundation

protocol VideoClientType {
    func getVideos(with page: Int) async throws -> VideosResponse
}

struct VideoClient: VideoClientType {
    
    private let client = NetworkClient()
    private let videoType: VideoTypeURL
    
    init(videoType: VideoTypeURL) {
        self.videoType = videoType
    }
    
    func getVideos(with page: Int) async throws -> VideosResponse {
        let urlParameters: [String: String] = ["page": "\(page)"]
        let request = URLRequestBuilder(path: videoType.getTypeBath,
                                        urlParameters: urlParameters)
        return try await client.sendRequest(request)
    }
    
}
