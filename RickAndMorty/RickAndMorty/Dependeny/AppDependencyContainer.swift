//
// AppDependencyContainer.swift


import Foundation
import Networking
import Characters

public protocol AppDependencyContainerType: CharactersDependencyContainerType {}

public final class AppDependencyContainer: AppDependencyContainerType {
    
    // MARK: - Properties
    private let charactersDependencyContainer: CharactersDependencyContainer
    
    // MARK: - AppDependencyContainerType
    public var characterService: AppServiceType {
        return charactersDependencyContainer.characterService
    }
    
    public var charactersDependency: CharactersDependencyContainer {
        return charactersDependencyContainer
    }
    
    // MARK: - Initialization
    public init() {
        let apiService = APIService()
        
        guard let baseUrl = AppDependencyContainer.getBaseURL() else {
            fatalError("Invalid base URL.")
        }
        
        self.charactersDependencyContainer = CharactersDependencyContainer(apiService: apiService, baseUrl: baseUrl)
    }
    
    // MARK: - Private Helpers
    private static func getBaseURL() -> URL? {
        guard let baseUrlString = Bundle.main.object(forInfoDictionaryKey: "BaseUrl") as? String else {
            return nil
        }
        return URL(string: baseUrlString)
    }
}
