//
//  VideoDataEntity+Entity.swift
//  BanquemisrChallenge05
//
//  Created by Alshimaa on 04/03/2024.
//

import Foundation

extension VideoDataResponse {
    func mapToVideoDataEntity() -> VideoDataEntity {
        VideoDataEntity(adult: adult ?? false,
                        backdropPath: backdropPath ?? "",
                        genreIDS: genreIDS ?? [],
                        id: id ?? 0,
                        originalLanguage: originalLanguage ?? "",
                        originalTitle:originalTitle ?? "",
                        overview: overview ?? "",
                        popularity: popularity ?? 0.0,
                        posterPath: posterPath ?? "",
                        releaseDate: releaseDate ?? "",
                        title: title ?? "",
                        voteAverage: voteAverage ?? 0.0,
                        voteCount: voteCount ?? 0)
    }
}
