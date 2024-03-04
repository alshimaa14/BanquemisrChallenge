//
//  URLRequestConvertible.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 04/03/2024.
//

import Foundation

//To provide the url is needed by the networkClient to build request
public protocol URLRequestConvertible {
    func build(_ endpoint: Endpoint) -> URLRequest
}

//Handle The build to be a default implement of building.
extension URLRequestConvertible {
    public func build(_ endpoint: Endpoint) -> URLRequest {
        let url = URL(string: endpoint.baseUrl)!.appendingPathComponent(endpoint.path)
        var urlComponents = URLComponents(url: url,
                                          resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = endpoint.urlParameters.map {key, value in
            URLQueryItem(name: key,
                         value: value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
        }
        var request = URLRequest(url: (urlComponents?.url!)!,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: endpoint.timeInterval)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = apiHeaders(headers: endpoint.headers)
        request.httpBody = endpoint.body?.toData()
        return request
    }
        
    private func apiHeaders(headers: [String: String]) -> [String: String] {
        var headers = headers
        return headers
    }
}
