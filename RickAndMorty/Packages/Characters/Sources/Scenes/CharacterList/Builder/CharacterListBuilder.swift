//
// CharacterListBuilder.swift


import Foundation
import UIKit
import Networking

protocol ApiServiceProviding {
    var apiService: APIServiceType { get }
    var baseUrl: URL { get }
}

class CharacterListBuilder {
    static func build(dependency: CharactersDependencyContainerType, actionCallback: CharacterListActionCallback?) -> UIViewController {
        
        let viewModel = CharacterListViewModel(service: dependency.characterService, actionCallback: actionCallback)
        let viewController = CharacterListViewController.instantiateFromStoryboard(with: "CharacterListViewController", in: Resources.bundle)
        viewController.viewModel = viewModel
        return viewController
    }
}


