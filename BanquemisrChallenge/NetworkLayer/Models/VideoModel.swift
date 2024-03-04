//
//  VideoModel.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 02/03/2024.
//

import Foundation

struct VideoDataModel: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalLanguage: String?
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}


struct VideoModel {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let voteAverage: Double
    let voteCount: Int
    
    init(response: VideoDataModel) {
        adult = response.adult ?? false
        backdropPath = response.backdropPath ?? ""
        genreIDS = response.genreIDS ?? []
        id = response.id ?? 0
        originalLanguage = response.originalLanguage ?? ""
        originalTitle = response.originalTitle ?? ""
        overview = response.overview ?? ""
        popularity = response.popularity ?? 0
        posterPath = response.posterPath ?? ""
        releaseDate = response.releaseDate ?? ""
        title = response.title ?? ""
        voteAverage = response.voteAverage ?? 0
        voteCount = response.voteCount ?? 0
    }
}
