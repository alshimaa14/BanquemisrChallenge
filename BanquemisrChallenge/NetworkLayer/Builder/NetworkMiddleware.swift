//
//  NetworkMiddleware.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 02/03/2024.
//

import Alamofire
import Foundation

class NetworkMiddleware: RequestAdapter, RequestRetrier {
    func retry(_: Request, for _: Session, dueTo _: Error, completion: @escaping (RetryResult) -> Void) {
        completion(.doNotRetry)
    }

    public lazy var sessionManager: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = HTTPHeaders.default.dictionary
        configuration.timeoutIntervalForResource = 60
        configuration.timeoutIntervalForRequest = 60
        let session = Session(configuration: configuration, interceptor: Interceptor(adapter: self, retrier: self))
        return session
    }()

    private var accessToken: String {
        return  ""
    }

    func adapt(_ urlRequest: URLRequest, for _: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var _urlRequest = urlRequest

        _urlRequest.setValue("enapplication/jsonUS", forHTTPHeaderField: "accept")

        _urlRequest.setValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwZDk3OTljNWM0ZTk4MzlhOGNkYjIwN2ExNjhjMmViZiIsInN1YiI6IjY1ZTBmM2Y4OWRlZTU4MDE0OTdiNTI2OSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.FwaUgg1DMixXdF8VXNDt9BjRg633OcZjQi9-yZgqb8k", forHTTPHeaderField: "Authorization")

        completion(.success(_urlRequest))
    }
}

