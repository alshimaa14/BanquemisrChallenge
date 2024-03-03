//
//  NetworkHandler.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 02/03/2024.
//

import Alamofire
import Foundation

enum MimeType: String {
    case jpg = "image/jpeg"
    case png = "image/png"
    case mp4 = "video/mp4"
}

typealias File = (name: String, key: String, mimeType: MimeType, data: Data)

class NetworkHandler {
    private let networkMiddleware = NetworkMiddleware()
    private lazy var manager: Session = {
        let manager = networkMiddleware.sessionManager
        return manager
    }()

    private var totalPages: Int!
    var _totalPages: Int {
        get {
            if totalPages == nil {
                totalPages = 0
            }
            return totalPages
        } set {
            totalPages = newValue
        }
    }

    private func verifyResponse(response: AFDataResponse<Data>) -> NetworkError? {
        print("Status Code : =", response.response?.statusCode ?? 0)
        
        if let error = response.error {
            if error.isSessionTaskError {
                return .noInternetConnection
            }
        }
        
        if let _ = response.error, (response.error as NSError?)?.code == -999 {
            return .cancelled
        }

        if let _ = response.error, (response.error as NSError?)?.code == -1009 {
            return .noInternetConnection
        }

        guard let _ = response.data else {
            return .invalidData
        }

        if let response = response.response, case 500 ... 511 = response.statusCode {
            return .internalServerError
        }

        if response.response?.statusCode != 200, response.response?.statusCode != 201, response.response?.statusCode != 204 {
            guard let jsonObject = try? JSONSerialization.jsonObject(with: response.data ?? Data(), options: []) as? [String: Any] else { return .internalServerError }
            if let message = jsonObject["message"] as? String {
                return .unknownError(message)
            } else {
                return .internalServerError
            }
        }

        return nil
    }

    private func extractPaginationData(from response: AFDataResponse<Data>) -> NetworkError? {
        guard let headers = response.response?.allHeaderFields as? [String: String] else {
            return .internalServerError
        }

        if let totalPages = headers["x-totalpages"] {
            self.totalPages = Int(totalPages)
        }

        return nil
    }

    private func sendRequest(_ request: URLRequestConvertible, debug: Bool = false) -> Future<Data> {
        let promise = Promise<Data>()
        manager.request(request).cURLDescription(calling: debugLog(description:)).responseData { [weak self] response in
            guard let self = self else { return }
            
            if debug {
                print("=====----->>>> debug", String(data: response.data ?? Data(), encoding: .utf8) ?? "")
            }

            if let error = self.verifyResponse(response: response) {
                print("=====----->>>> error", error)
                promise.reject(with: error)
                return
            }

            if let error = self.extractPaginationData(from: response) {
                print("=====----->>>> ⛔️⛔️⛔️", error)
                promise.reject(with: error)
                return
            }

            switch response.result {
            case let .success(data):
                
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        print("=====----->>>> paramters", request.parameters ?? [:])
                        print("=====----->>>> data",  json)
                    }
                }catch let error {
                    print("Failed to load: \(error.localizedDescription)")
                }
                
                promise.resolve(with: data)
            case let .failure(error):
                print("=====----->>>> error", error)
                promise.reject(with: error)
            }
        }
        print("ddd",promise)
        return promise
    }

    func upload(files: [File]?, to request: URLRequestConvertible, debug: Bool = false) -> Future<Data> {
        let promise = Promise<Data>()

        manager.upload(multipartFormData: { formData in

            if let files = files {
                files.forEach { file in
                    formData.append(file.data, withName: file.key, fileName: file.name, mimeType: file.mimeType.rawValue)
                }
            }

            if let parameters = request.parameters {
                parameters.forEach { k, v in
                    formData.append("\(v)".data(using: .utf8) ?? Data(), withName: k)
                }
            }
        }, with: request).cURLDescription(calling: debugLog(description:)).responseData { [weak self] response in

            guard let self = self else { return }

            if debug {
                print(String(data: response.data ?? Data(), encoding: .utf8) ?? "")
            }

            if let error = self.verifyResponse(response: response) {
                print(error.localizedDescription)
                promise.reject(with: error)
                return
            }

            switch response.result {
            case let .success(data):
                promise.resolve(with: data)
            case let .failure(error):
                promise.reject(with: error)
            }
        }

        return promise
    }

    private func debugLog(description: String) {
        print("=======================================")
        print(description)
        print("=======================================")
    }

    func invalidateAllRequests() {
        manager.session.getAllTasks { tasks in tasks.forEach { $0.cancel() } }
    }
}


extension NetworkHandler {
    func request<DecodedModel: Decodable>(_ request: URLRequestConvertible, debug: Bool = false) async throws -> DecodedModel {
        return try await withCheckedThrowingContinuation({ [weak self] continuation in
            guard let self = self else { return }
            do {
                try self.sendRequest(request, debug: debug)
                    .decoded(toType: DecodedModel.self)
                   .observe { result in
                       switch result {
                       case .success(let model):
                           continuation.resume(returning: model)
                       case .failure(let error):
                           continuation.resume(throwing: error)
                       }
                   }
            } catch {
                continuation.resume(throwing: error)
            }
        })
    }
}
