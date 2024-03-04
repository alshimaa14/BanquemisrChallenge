//
//  IndicatorState.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 29/02/2024.
//

import Foundation

public enum IndicatorState {
    case loading(userInterAction: Bool, hideView: Bool)
    case loaded
    case none
}
