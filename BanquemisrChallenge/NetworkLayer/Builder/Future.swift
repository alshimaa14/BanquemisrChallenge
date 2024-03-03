//
//  Future.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 02/03/2024.
//

import Foundation

class Future<Value> {
    var result: Result<Value, Error>? {
        didSet { result.map(report) }
    }

    private lazy var callbacks = [(Result<Value, Error>) -> Void]()

    func observe(with callback: @escaping (Result<Value, Error>) -> Void) {
        callbacks.append(callback)
        result.map(callback)
    }

    private func report(result: Result<Value, Error>) {
        for callback in callbacks {
            callback(result)
        }
    }
}

extension Future {
    func chained<NextValue>(with closure: @escaping (Value) throws -> Future<NextValue>) -> Future<NextValue> {
        let promise = Promise<NextValue>()

        observe { result in
            switch result {
            case let .success(value):
                do {
                    let future = try closure(value)

                    future.observe { result in
                        switch result {
                        case let .success(value):
                            promise.resolve(with: value)
                        case let .failure(error):
                            promise.reject(with: error)
                        }
                    }
                } catch {
                    promise.reject(with: error)
                }
            case let .failure(error):
                promise.reject(with: error)
            }
        }

        return promise
    }

    func transformed<NextValue>(with closure: @escaping (Value) throws -> NextValue) -> Future<NextValue> {
        return chained { value in
            try Promise(value: closure(value))
        }
    }
}
