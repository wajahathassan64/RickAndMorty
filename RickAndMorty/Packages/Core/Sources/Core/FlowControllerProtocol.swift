//
// FlowControllerProtocol.swift


import Foundation
import UIKit

public protocol FlowControllerProtocol: AnyObject {
    /// Description
    /// associatedtype DependencyContainer in the FlowControllerProtocol defines a placeholder for a type that will be specified when a concrete class conforms to the protocol. 
    /// This allows the protocol to be more flexible and reusable across different flow controllers with various types of dependencies.
    associatedtype DependencyContainer
    
    init(rootNavigationController: UINavigationController?,
         dependency: DependencyContainer)
    func startFlow()
}
