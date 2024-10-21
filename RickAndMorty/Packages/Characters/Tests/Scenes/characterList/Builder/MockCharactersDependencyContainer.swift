//
// Filename.swift


import Foundation
@testable import Characters
@testable import Networking

class MockCharactersDependencyContainer: CharactersDependencyContainerType {
    
    var characterService: AppServiceType
    
    init(characterService: AppServiceType) {
        self.characterService = characterService
    }
}
