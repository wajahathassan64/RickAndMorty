//
//  UITableViewCell+Ext.swift


import Foundation
import UIKit

public extension UITableViewCell {
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
}
