//
// RMAppFlowController.swift


import UIKit
import Core
import Characters

class RMAppFlowController: FlowController<CharactersDependencyContainerType> {
    // MARK: - Propreties
    var myCharactersFlowController: CharactersFlowController?
    var window: UIWindow?
    
    // MARK: - Initialization
    required init(rootNavigationController: UINavigationController?,
                  dependency: CharactersDependencyContainerType) {
        super.init(rootNavigationController: rootNavigationController,
                   dependency: dependency)
    }
    
    // MARK: - Flow
    func startFlow(window: UIWindow) {
        self.window = window
        startCharacters()
    }
    
    func startCharacters() {
        myCharactersFlowController = CharactersFlowController(rootNavigationController: rootNavigationController,
                                                      dependency: dependency)
        myCharactersFlowController?.startFlow()
        myCharactersFlowController?.stopFlowActionCallBack = { [weak self] in
            self?.myCharactersFlowController = nil
        }
    }
}

