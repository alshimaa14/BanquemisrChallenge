//
//  URLRequestConvertible.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 02/03/2024.
//

import Alamofire
import Foundation

protocol URLRequestConvertible: Alamofire.URLRequestConvertible {
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var urlPath: String { get }
    var url: URL { get }
    var encoding: ParameterEncoding { get }
}

extension URLRequestConvertible {
    var url: URL {
        return URL(string: Constants.baseUrl)!.appendingPathComponent(urlPath)
    }

    public func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return try encoding.encode(urlRequest, with: parameters)
    }
}


public struct RequestBuilder: URLRequestConvertible {
    let method: Alamofire.HTTPMethod
    let urlPath: String
    let parameters: [String : Any]?
    let encoding: Alamofire.ParameterEncoding
    let url: URL
    
    init(method: Alamofire.HTTPMethod = .get,
         urlPath: String,
         parameters: [String : Any]? = nil,
         encoding: Alamofire.ParameterEncoding = URLEncoding.default,
         baseUrl: String = Constants.baseUrl) {
        self.method = method
        self.parameters = parameters
        self.urlPath = urlPath
        self.encoding = encoding
        self.url = URL(string: baseUrl)!.appendingPathComponent(urlPath)
    }
    
}
