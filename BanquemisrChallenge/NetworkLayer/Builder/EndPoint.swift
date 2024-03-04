//
//  EndPoint.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 04/03/2024.
//

import Foundation

//To handle Error provided by networkClient
public protocol NetworkClientTypeErrorDelegate {
    func handleError(error: Error, responseTypeName: String)
}

//To implement the EndPoints are needed by the URLRequestConvertiable
public protocol Endpoint {
    var baseUrl: String { get }
    var path: String { get }
    var headers: [String: String] { get }
    var urlParameters: [String: String] { get }
    var body: Encodable? { get }
    var method: HTTPMethod { get }
    var timeInterval: Double { get }
}

