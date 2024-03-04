//
//  UITableView.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 29/02/2024.
//

import Foundation
import UIKit

extension UITableView {
    convenience init<T: UITableViewCell>(cellType: T.Type) {
        self.init(frame: .zero)
        register(cellType.self, forCellReuseIdentifier: cellType.className)
    }

    func dequeue<T: UITableViewCell>(indexPath: IndexPath, type: T.Type) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: type), for: indexPath) as! T
    }

    func dequeueCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.className, for: indexPath) as! T
    }

}

// MARK: - Reload TableView
public extension UITableView {
    func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.reloadData()
        }
    }
}

extension NSObject {
    class var className: String {
        return "\(self)"
    }
}
