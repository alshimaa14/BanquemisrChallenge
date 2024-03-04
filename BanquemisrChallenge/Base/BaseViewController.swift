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
    
    private lazy var indicatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightText
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.isHidden = true
        return view
    }()
    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        indicator.style = .large
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackButtonTitle()
        setupBaseViewModelBinding()
        setupViewsConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}

// MARK: configuration
private extension BaseViewController {
    
    func setupBackButtonTitle() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func setupViewsConstraints() {
        addSibViews()
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            indicatorView.widthAnchor.constraint(equalToConstant: 100),
            indicatorView.heightAnchor.constraint(equalToConstant: 100),
        ])
        
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: indicatorView.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: indicatorView.centerYAnchor)
        ])
    }
    
    func addSibViews() {
        view.addSubview(indicatorView)
        indicatorView.addSubview(indicator)
    }
    
}

// MARK: ViewModel Binding
private extension BaseViewController {
    
    func setupBaseViewModelBinding() {
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
    }
}


// MARK: Handle the indicator
private extension BaseViewController {
    
    func setupIndicator(state: IndicatorState) {
        switch state {
        case let .loading(userInterAction, hideView):
            
            if hideView {
                _ = view.subviews.map { $0.isHidden = true }
            }
            if userInterAction {
                view.isUserInteractionEnabled = false
            }
            indicatorView.isHidden = false
            
        case .loaded:
            view.isUserInteractionEnabled = true
            _ = self.view.subviews.map { $0.isHidden = false }
            _ = view.subviews.map { $0.isHidden = false }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                guard let _ = self else { return }
            }
            indicatorView.isHidden = true
        case .none:
            break
        }
    }
}


