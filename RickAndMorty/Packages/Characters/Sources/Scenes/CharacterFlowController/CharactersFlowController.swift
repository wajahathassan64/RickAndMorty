//
// CharactersFlowController.swift


import Foundation
import UIKit
import Core

public class CharactersFlowController: FlowController<CharactersDependencyContainerType> {
    
    // MARK: - Initialization
    required init(rootNavigationController: UINavigationController?, dependency: CharactersDependencyContainerType) {
        super.init(rootNavigationController: rootNavigationController, dependency: dependency)
    }
    
    public override func startFlow() {
        let viewController = CharacterListBuilder.build(dependency: dependency) { action in
            switch action {
                
            case .openDetails(let character):
                print("Character lists = ", character)
            }
            print("Action called")
        }
        
        rootNavigationController?.pushViewController(viewController, animated: true)
    }
}
