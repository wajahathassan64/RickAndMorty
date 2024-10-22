//
// AppDependencyContainer.swift


import Foundation
import Networking
import Characters

public protocol AppDependencyContainerType: CharactersDependencyContainerType {}

public final class AppDependencyContainer: AppDependencyContainerType {
    
    private let charactersDependencyContainer: CharactersDependencyContainer
    
    public var characterService: AppServiceType {
        return charactersDependencyContainer.characterService
    }
    
    public var charactersDependency: CharactersDependencyContainer {
        return charactersDependencyContainer
    }
    
    public init() {
        
        let apiService = APIService()
        
        guard let baseUrlString = Bundle.main.object(forInfoDictionaryKey: "BaseUrl") as? String,
              let baseUrl = URL(string: baseUrlString) else {
            fatalError("Invalid base URL.")
        }
        
        self.charactersDependencyContainer = CharactersDependencyContainer(apiService: apiService, baseUrl: baseUrl)
    }
}
