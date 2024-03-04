//
//  Encodable+Dictionary.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 04/03/2024.
//

import Foundation
extension Encodable {
    private func toDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }
        let jsonObject = try? JSONSerialization.jsonObject(with: data,
                                                           options: .allowFragments)
        
        return jsonObject.flatMap { $0 as? [String: Any] } ?? [:]
    }
    
    func toData() -> Data? {
        try? JSONSerialization.data(withJSONObject: self.toDictionary(), options: .prettyPrinted)
    }
}
