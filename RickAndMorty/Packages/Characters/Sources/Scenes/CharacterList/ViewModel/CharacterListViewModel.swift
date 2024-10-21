//
// CharacterListViewModel.swift


import Foundation
protocol CharacterListViewModelType {
    var numberOfSections: Int { get }
}

typealias CharacterListActionCallback = () -> Void

final class CharacterListViewModel: CharacterListViewModelType {
    // MARK: - Properties
    var numberOfSections: Int
    
    private let service: AppServiceType
    private let actionCallback: CharacterListActionCallback?
    
    // MARK: - Initializer
    init(service: AppServiceType, actionCallback: CharacterListActionCallback?) {
        self.service = service
        self.actionCallback = actionCallback
        self.numberOfSections = 1
    }
    
}
