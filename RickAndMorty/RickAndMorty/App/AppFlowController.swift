//
// AppFlowController.swift


import UIKit
import Core
import Characters

class AppFlowController: FlowController<CharactersDependencyContainerType> {
    
    // MARK: - Properties
    private var charactersFlowController: CharactersFlowController?
    private weak var window: UIWindow?
    
    // MARK: - Initialisation
    required init(rootNavigationController: UINavigationController?, dependency: CharactersDependencyContainerType) {
        super.init(rootNavigationController: rootNavigationController, dependency: dependency)
    }
    
    // MARK: - Public Flow Start
    func startFlow(in window: UIWindow) {
        self.window = window
        startCharactersFlow()
    }
    
    // MARK: - Private Flow Control
    private func startCharactersFlow() {
        let flowController = CharactersFlowController(rootNavigationController: rootNavigationController, dependency: dependency)
        flowController.startFlow()
        flowController.stopFlowActionCallBack = { [weak self] in
            self?.charactersFlowController = nil
        }
        charactersFlowController = flowController
    }
}
