//
//  VideosEntity.swift
//  BanquemisrChallenge05
//
//  Created by Alshimaa on 04/03/2024.
//

struct VideosEntity {
    let page: Int
    let results: [VideoDataEntity]
    let totalPages, totalResults: Int
    
    init(page: Int,
         results: [VideoDataEntity],
         totalPages: Int,
         totalResults: Int) {
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
}
