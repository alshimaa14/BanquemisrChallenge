//
//  NetworkClient.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 04/03/2024.
//

import Foundation

public class NetworkClient {
    
    private let session: URLSession
    
    public init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
}


//MARK: -  implementation with Async and await
extension NetworkClient: NetworkClientType {
    
    public func sendRequest<ResponseType: Decodable>(_ request: Endpoint) async throws -> ResponseType {
       
        do {
            
            let request = build(request)

            let (data, response) = try await session.data(for: request)
            
            guard let response = response as? HTTPURLResponse else {
                throw NetworkError.noInternetConnection
            }
            
            log(with: request, data, response)
            
            if let error = VerifyResponse.checkResponseError(for: response, data: data) {
                throw error
            }
            
            guard let decodedData = try? JSONDecoder()
                .decode(ResponseType.self, from: data) else {
                throw NetworkError.decodingFailed
            }
            
            return decodedData
            
        } catch {
            if let noInternetError = error as NSError?,
               noInternetError.code == NSURLErrorNotConnectedToInternet,
               noInternetError.domain == NSURLErrorDomain {
                throw NetworkError.noInternetConnection
            }
            throw error
        }
    }
}


private extension NetworkClient {
    func log(with request: URLRequest, _ data: Data, _ response: HTTPURLResponse) {
        debugPrint("============Request==============")
        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = NSURLComponents(string: urlAsString)
        let method = request.httpMethod != nil ? "HttpMethod:- \(request.httpMethod ?? "")" : ""
        let path = "Path:- \(urlComponents?.path ?? "")"
        let query = "Query:- \(urlComponents?.query ?? "")"
        debugPrint(urlAsString)
        debugPrint(method)
        debugPrint(path)
        debugPrint(query)
        debugPrint("============Response==============")
        debugPrint("status code:- \(response.statusCode)")
        debugPrint(String(decoding: data, as: UTF8.self))
    }
}
