//
// InstantiableType.swift


import Foundation
import UIKit

protocol InstantiableType: AnyObject { }

extension InstantiableType where Self: UIViewController {
    static func instantiateFromStoryboard(
        with storyboardName: String,
        in bundle: Bundle = .main
    ) -> Self {
        create(from: UIStoryboard(name: storyboardName, bundle: bundle))
    }
}

private extension InstantiableType {
    static var identifier: String {
        String(describing: self)
    }
    
    static func create<T>(
        from storyboard: UIStoryboard
    ) -> T {
        storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
}
