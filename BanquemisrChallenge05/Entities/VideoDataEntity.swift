//
//  VideoDataEntity.swift
//  BanquemisrChallenge05
//
//  Created by Alshimaa on 04/03/2024.
//

import Foundation

struct VideoDataEntity {
    
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
    
    init(adult: Bool,
         backdropPath: String,
         genreIDS: [Int],
         id: Int,
         originalLanguage: String,
         originalTitle: String,
         overview: String,
         popularity: Double,
         posterPath: String,
         releaseDate: String,
         title: String,
         voteAverage: Double,
         voteCount: Int) {
        
        self.adult = adult
        self.backdropPath = backdropPath
        self.genreIDS = genreIDS
        self.id = id
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
}
