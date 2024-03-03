//
//  BaseViewModel.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 29/02/2024.
//

import Foundation
import Combine

public enum IndicatorState {
    case loading(userInterAction: Bool, hideView: Bool)
    case loaded
    case none
    case startShimmer
    case stopShimmer
}

protocol BaseViewModelProtocol {
    var isNoInternetConnection : CurrentValueSubject<Bool, Never> {get set}
    var cartCount : CurrentValueSubject<Int, Never> {get set}
    var showAlertMessage : PassthroughSubject<String, Never> {get set}
    var showPopableMessage: PassthroughSubject<String, Never> {get set}
    var indicatorState: PassthroughSubject<IndicatorState, Never> { get set }
    func retryToCallLastService()
}

public class BaseViewModel: BaseViewModelProtocol {
    
    var isNoInternetConnection = CurrentValueSubject<Bool, Never>(false)
    var cartCount = CurrentValueSubject<Int, Never>(0)
    var showAlertMessage = PassthroughSubject<String, Never>()
    var showPopableMessage = PassthroughSubject<String, Never>()

    var indicatorState = PassthroughSubject<IndicatorState, Never>()
    
    public var indicator: IndicatorState = .none {
        didSet {
            indicatorState.send(indicator)
        }
    }
    
    func didFetchError(_ error: Error?) {
        indicator = .loaded
        indicator = .stopShimmer
        showAlertMessage.send(error?.localizedDescription ?? "")
    }

    
    func retryToCallLastService() { }
}


