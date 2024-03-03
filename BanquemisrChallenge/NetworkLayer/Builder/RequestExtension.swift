//
//  RequestExtension.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 02/03/2024.
//

import Alamofire
import Foundation

public extension Request {
    func debugLog() -> Self {
        #if DEBUG
        print("-------------------------------")
            debugPrint(self)
        print("-------------------------------")
        #endif
        return self
    }
}
