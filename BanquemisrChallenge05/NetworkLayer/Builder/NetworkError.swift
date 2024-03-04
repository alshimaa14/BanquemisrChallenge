//
//  NetworkError.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 02/03/2024.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case cancelled
    case noInternetConnection
    case invalidData
    case internalServerError
    case unknownError(String)
    case unauthorized
    case unverified
    case decodingFailed

    var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return NSLocalizedString("No Internet connection", comment: "")
        case .invalidData:
            return NSLocalizedString("Invalid Data", comment: "")
        case .internalServerError:
            return NSLocalizedString("Something Went Wrong", comment: "")
        case let .unknownError(error):
            return error
        case .cancelled:
            return NSLocalizedString("Cancelled", comment: "")
        case .unauthorized:
            return NSLocalizedString("Unauthorized", comment: "")
        default:
            return ""
        }
    }
}
