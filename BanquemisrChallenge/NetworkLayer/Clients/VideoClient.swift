//
//  VideoClient.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 02/03/2024.
//

import Foundation

protocol VideoClientType {
    func getVideos(videoType: VideoTypeURL) async throws -> VideoResponseDataModel
}

class VideoClient: VideoClientType {

    private let client = NetworkHandler()
    
    func getVideos(videoType: VideoTypeURL) async throws -> VideoResponseDataModel {
        let request = RequestBuilder(urlPath: videoType.rawValue)
        return try await client.request(request)
    }
    
}
