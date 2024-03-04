//
//  Cellable.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 29/02/2024.
//

import UIKit

public protocol Cellable {
    static var identifier: String { get }
    static var nib: UINib { get }
}

private extension Cellable where Self: UIView {

    static func instanceFromTable<T: UIView>(_ tableView: UITableView, identifier: String? = nil) -> T
    {
        return tableView.dequeueReusableCell(withIdentifier: identifier ?? self.identifier) as! T
    }
}

extension UIView: Cellable {
    public static var identifier: String {
        return NSStringFromClass(Self.self).components(separatedBy: ".").last!
    }

    public static var nib: UINib {
        return .init(nibName: identifier, bundle: nil)
    }
}

extension UITableViewCell {
    class func instance(_ tableView: UITableView, identifier: String? = nil) -> Self {
        return instanceFromTable(tableView, identifier: identifier)
    }
}
