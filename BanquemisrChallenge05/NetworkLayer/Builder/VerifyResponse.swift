//
//  VerifyResponse.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 04/03/2024.
//

import Foundation

struct VerifyResponse {
    
    public static func checkResponseError(for response: HTTPURLResponse,
                                          data: Data?) -> NetworkError? {
        switch response.statusCode {
        case 200...299:
            return nil
        case 401:
            return NetworkError.unauthorized
        case 400,
            402...500:
            return decodeError(from: data)
            
        case 501...599:
            return NetworkError.internalServerError
            
        case URLError.Code.notConnectedToInternet.rawValue, URLError.Code.networkConnectionLost.rawValue:
            return .noInternetConnection
            
        default:
            return NetworkError.unverified
        }
    }
    
    private static func decodeError(from data: Data?) -> NetworkError {
        do {
            guard let responseData = data else {
                return NetworkError.invalidData
            }
            let errorData = try JSONDecoder()
                .decode(ServerErrorResponse.self, from: responseData)
            return NetworkError.unknownError(errorData.message ?? "")
        } catch {
            debugPrint("Decode response error:>>", error)
            return NetworkError.decodingFailed
        }
    }
}
