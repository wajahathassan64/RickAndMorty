//
// CharactersDependencyContainer.swift


import Foundation
import Networking
import Core

public protocol CharactersDependencyContainerType: DependencyType {
    var characterService: AppServiceType { get }
}

public final class CharactersDependencyContainer: CharactersDependencyContainerType {
    
    // Dependencies
    private let apiService: APIServiceType
    private let baseUrl: URL
    
    public let characterService: AppServiceType
    
    public init(apiService: APIServiceType, baseUrl: URL) {
        self.apiService = apiService
        self.baseUrl = baseUrl
        self.characterService = CharacterService(apiService: apiService, baseUrl: baseUrl)
    }
}

