//
//  BaseViewModel.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 29/02/2024.
//

import Foundation
import Combine

protocol BaseViewModelProtocol {
    var showAlertMessage : PassthroughSubject<String, Never> {get set}
    var indicatorState: PassthroughSubject<IndicatorState, Never> { get set }
}

public class BaseViewModel: BaseViewModelProtocol {
    
    var showAlertMessage = PassthroughSubject<String, Never>()
    var indicatorState = PassthroughSubject<IndicatorState, Never>()
    
    public var indicator: IndicatorState = .none {
        didSet {
            indicatorState.send(indicator)
        }
    }
    
    func didFetchError(_ error: Error?) {
        indicator = .loaded
        showAlertMessage.send(error?.localizedDescription ?? "")
    }
}


