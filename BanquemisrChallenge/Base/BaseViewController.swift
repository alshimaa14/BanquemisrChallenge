//
//  BaseViewController.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 29/02/2024.
//



import UIKit
import Combine

protocol HasActivityIndicator: AnyObject {
    func showActivityIndicator(isUserInteractionEnabled: Bool)
    func hideActivityIndicator()
    func alert(with message: String)
}

class BaseViewController: UIViewController {

    private var cancelable = Set<AnyCancellable>()
    var baseViewModel: BaseViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackButtonImage()
        seuptBaseViewModelBiniding()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    private func setupBackButtonImage() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

}

extension BaseViewController: HasActivityIndicator {
    func showActivityIndicator(isUserInteractionEnabled: Bool) {
        view.showActivityIndicator(isUserInteractionEnabled: isUserInteractionEnabled)
    }

    func hideActivityIndicator() {
        UIView.animate(withDuration: 0.2) {
            _ = self.view.subviews.map { $0.isHidden = false }
        }
        view.hideActivityIndicator()
    }

    func alert(with message: String) {
        showAlert(with: message)
    }
}

extension BaseViewController {
    
    private func seuptBaseViewModelBiniding() {
        baseViewModel.indicatorState
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
            guard let self = self else { return }

            self.setupIndicator(state: state)
        }.store(in: &cancelable)

        baseViewModel.showAlertMessage
            .receive(on: RunLoop.main)
            .sink { [weak self] message in
            guard let self = self else { return }
            self.showAlert(with: message)
        }.store(in: &cancelable)

        baseViewModel.showPopableMessage
            .receive(on: RunLoop.main)
            .sink { [weak self] message in
            guard let self = self else { return }
                self.showPopableAlert(with: message) {
                    self.navigationController?.popViewController(animated: true)
                }
        }.store(in: &cancelable)

        baseViewModel.cartCount
            .receive(on: RunLoop.main)
            .sink { [weak self] count in
            guard let _ = self else { return }
        }.store(in: &cancelable)

    }

    private func setupIndicator(state: IndicatorState) {
        switch state {
        case let .loading(userInterAction, hideView):

            if hideView {
                _ = view.subviews.map { $0.isHidden = true }
            }
            view.showActivityIndicator(isUserInteractionEnabled: userInterAction)
            if userInterAction {
                view.isUserInteractionEnabled = false
            }

        case .loaded:
            view.isUserInteractionEnabled = true
            _ = self.view.subviews.map { $0.isHidden = false }
            _ = view.subviews.map { $0.isHidden = false }
            view.hideActivityIndicator()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                guard let _ = self else { return }
            }
        case .startShimmer:
            return

        case .stopShimmer:
            return
        case .none:
            break
        }
    }
}



extension BaseViewController {
    func retryToConnect() {
        baseViewModel.retryToCallLastService()
    }
}


