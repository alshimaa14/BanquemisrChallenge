//
//  FutureDecoded.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 02/03/2024.
//

import Foundation

extension Future where Value == Data {
    func decoded<NextValue: Decodable>(toType _: NextValue.Type, withKeyPath _: String = "", debug _: Bool = false) throws -> Future<NextValue> {
        return transformed {
            do {
                return try JSONDecoder().decode(NextValue.self, from: $0)
            } catch {
                print("Decode response error:>>", error)
                throw error
            }
        }
    }
}
