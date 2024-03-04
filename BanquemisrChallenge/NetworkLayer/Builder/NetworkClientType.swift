//
//  NetworkClientType.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 04/03/2024.
//

import Foundation

public protocol NetworkClientType: URLRequestConvertible {
    func sendRequest<ResponseType: Decodable>(_ request: Endpoint) async throws -> ResponseType
}
