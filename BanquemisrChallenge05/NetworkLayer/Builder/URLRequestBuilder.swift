//
//  URLRequestBuilder.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 04/03/2024.
//

import Foundation

struct URLRequestBuilder: Endpoint {

    var timeInterval: Double { return 60}

    var baseUrl: String {
        return Constants.baseUrl
    }

    var headers: [String: String] {
        var headers: [String: String] = [:]
        headers["Authorization"] = "Bearer \(Constants.staticUserToken)"
        headers["accept"] = "enapplication/jsonUS"
        return headers
    }

    let path: String
    let urlParameters: [String: String]
    let body: Encodable?
    let method: HTTPMethod

    init(path: String,
         method: HTTPMethod = .get,
         urlParameters: [String: String] = [:],
         body: Encodable? = nil) {
        self.method = method
        self.body = body
        self.urlParameters = urlParameters
        self.path = path
    }
}


