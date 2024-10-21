//
// FlowControllerProtocol.swift


import Foundation
import UIKit

public protocol Deinitcallable: AnyObject {
    var onDeinit: (() -> Void)? { get set }
}

public protocol FlowControllerProtocol: AnyObject {
    /// Description
    /// associatedtype DependencyContainer in the FlowControllerProtocol defines a placeholder for a type that will be specified when a concrete class conforms to the protocol. 
    /// This allows the protocol to be more flexible and reusable across different flow controllers with various types of dependencies.
    associatedtype DependencyContainer
    
    var deallocallable: Deinitcallable? { get set }
    var stopFlowActionCallBack: (() -> Void)? { get set }
    
    init(rootNavigationController: UINavigationController?,
         dependency: DependencyContainer)

    func startFlow()
}

public extension FlowControllerProtocol {
    // On key object can be active at a time.
    // Calling multiple times will just replace the previous object
    func setDeallocallable(with object: Deinitcallable) {
        deallocallable?.onDeinit = nil
        object.onDeinit = {[weak self] in
            self?.stopFlowActionCallBack?()
        }
        deallocallable = object
    }
}
