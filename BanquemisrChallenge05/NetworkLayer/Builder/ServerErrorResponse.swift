//
//  ServerErrorResponse.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 04/03/2024.
//


import Foundation

public struct ServerErrorResponse: Decodable {
    public let message: String?
    public let status: String?

    private enum CodingKeys: String, CodingKey {
        case status
        case message
    }
}
