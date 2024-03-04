//
//  VideosResponse+Entity.swift
//  BanquemisrChallenge05
//
//  Created by Alshimaa on 04/03/2024.
//

import Foundation

extension VideosResponse {
    func mapToVideosEntity() -> VideosEntity {
        VideosEntity(page: page ?? 1,
                     results: results?.map { $0.mapToVideoDataEntity() } ?? [],
                     totalPages: totalPages ?? 1,
                     totalResults: totalResults ?? 1)
    }
    
}
