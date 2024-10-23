//
// MockNavigationController.swift


import Foundation
import UIKit

class MockNavigationController: UINavigationController {
    var pushedViewController: UIViewController?
    var poppedViewController: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        super.pushViewController(viewController, animated: animated)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        poppedViewController = super.popViewController(animated: animated)
        return poppedViewController
    }
}
