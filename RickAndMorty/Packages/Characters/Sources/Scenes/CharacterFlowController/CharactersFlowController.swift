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
    
    // MARK: - Start Flow
    public override func startFlow() {
        let viewController = buildCharacterListViewController()
        setRootViewController(viewController)
    }
}

// MARK: - Private Methods
extension CharactersFlowController {
    
    func buildCharacterListViewController() -> UIViewController {
        return CharacterListBuilder.build(dependency: dependency) { [weak self] action in
            guard let self = self else { return }
            self.handleCharacterListAction(action)
        }
    }
    
    func handleCharacterListAction(_ action: CharacterListAction) {
        action.execute(on: self)
    }
    
    func navigateToCharacterDetails(_ character: Character) {
        let viewController = buildCharacterDetailsViewController(for: character)
        showCharacterDetails(viewController)
    }
    
    func buildCharacterDetailsViewController(for character: Character) -> UIViewController {
        return CharacterDetailsBuilder.build(character: character) { [weak self] action in
            guard let self = self else { return }
            action.execute(on: self)
        }
    }
    
    func navigateBackFromDetails() {
        showNavigationBar()
        popViewController()
    }
    
    func showCharacterDetails(_ viewController: UIViewController) {
        hideNavigationBar()
        pushViewController(viewController)
    }
    
}
