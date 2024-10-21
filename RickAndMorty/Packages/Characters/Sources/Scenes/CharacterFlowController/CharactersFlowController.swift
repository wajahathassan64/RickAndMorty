//
// Filename.swift


import Foundation
import UIKit
import Core


class CharactersFlowController: FlowController<CharactersDependencyContainerType> {

    // MARK: - Initialization
    required init(rootNavigationController: UINavigationController?, dependency: CharactersDependencyContainerType) {
        super.init(rootNavigationController: rootNavigationController, dependency: dependency)
    }
    
    public override func startFlow() {
        let viewController = CharacterListBuilder.build(dependency: dependency) {
            print("Action called")
        }
        
        rootNavigationController?.setViewControllers([viewController], animated: true)
    }
}
