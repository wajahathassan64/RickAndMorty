//
//  UIView+Ext.swift


import UIKit
import SwiftUI

public extension UIView {    
    func embedView(_ subview: UIView, insets: UIEdgeInsets = .zero) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
            subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insets.bottom),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets.right)])
    }
    
    func host<Content: View>(_ content: Content) {
        subviews.forEach { $0.removeFromSuperview() }
        let hostingController = UIHostingController(rootView: content)
        hostingController.view.backgroundColor = .clear
        embedView(hostingController.view)
        superview?.layoutIfNeeded()
    }
}

extension UIView {
    @objc
    open func configure(with viewModel: Any) {
        // An optional implementation.
        // Must be implemented if `viewModel` has to be configured.
        assertionFailure("configure(with viewModel: Any) needs to be overridden")
    }
}
