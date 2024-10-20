//
// UITableViewHeaderFooterView+Ext.swift


import Foundation
import UIKit

public extension UITableViewHeaderFooterView {
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
}
