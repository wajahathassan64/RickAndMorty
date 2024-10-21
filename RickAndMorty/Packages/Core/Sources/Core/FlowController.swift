//
// FlowController.swift


import UIKit

open class FlowController<DependencyContainer>: NSObject, FlowControllerProtocol {
    public var rootNavigationController: UINavigationController?
    public let dependency: DependencyContainer
    
    public var stopFlowActionCallBack: (() -> Void)?
    // Weak deallocallable to break reference cycle
    public weak var deallocallable: Deinitcallable?
    
    public required init(rootNavigationController: UINavigationController?,
                         dependency: DependencyContainer) {
        self.rootNavigationController = rootNavigationController
        self.dependency = dependency
    }
    
    open func startFlow() {
        assertionFailure("this method should be overridden")
    }
    
    open func deallocate() {
        assertionFailure("this method should be overridden")
    }

    open func pushViewController(_ viewController: UIViewController, animated: Bool = true) {
        DispatchQueue.main.async {
            self.rootNavigationController?.pushViewController(viewController, animated: animated)
        }
    }
    
    open func presentViewController(_ viewController: UIViewController,
                                    animated: Bool = true,
                                    completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            self.rootNavigationController?.present(viewController,
                                                   animated: animated,
                                                   completion: completion)
        }
    }
    
    open func popViewController(animated: Bool = true) {
        DispatchQueue.main.async {
            self.rootNavigationController?.popViewController(animated: animated)
        }
    }
    
    open func popToRootViewController(animated: Bool = true) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.rootNavigationController?.popToRootViewController(animated: animated)
        }
    }
    
    open func popToViewController(_ viewController: UIViewController,
                                  animated: Bool = true,
                                  completion: (([UIViewController]?) -> Void)? = nil) {
        DispatchQueue.main.async {
            let poppedViewController = self.rootNavigationController?.popToViewController(viewController,
                                                                                          animated: animated)
            completion?(poppedViewController)
        }
    }
    
    @available(*, deprecated, renamed: "dismissViewController(animated:completion:)")
    open func dissmissViewController(animated: Bool = true,
                                     completion: (() -> Void)? = nil) {
        dismissViewController(animated: animated, completion: completion)
    }

    open func dismissViewController(animated: Bool = true, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            guard self.rootNavigationController?.presentedViewController != nil else {
                completion?()
                return
            }
            self.rootNavigationController?.dismiss(animated: animated,
                                                   completion: completion)
        }
    }
    
    open func clearNavigationStack() {
        // Emptying navigation stack to deallocate view controller
        self.rootNavigationController?.viewControllers = []
        // Will be setting dashboard as window root VC, so ending rootNavigation life here
        self.rootNavigationController = nil
    }
}

// MARK: - Flow controller animations
public extension FlowController {
    func animatedWithWindow(_ window: UIWindow,
                            completion: ((Bool) -> Void)? = nil) {
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: {
                            // Though `animations` is optional, the documentation tells us that it must not be nil.
                          }, completion: completion)
    }
}
