//
//  VideosResponse.swift
//  BanquemisrChallenge05
//
//  Created by Alshimaa on 02/03/2024.
//

import Foundation

struct VideosResponse: Decodable {
    let page: Int?
    let results: [VideoDataResponse]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}


