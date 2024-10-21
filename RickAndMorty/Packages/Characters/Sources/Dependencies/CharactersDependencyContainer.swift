//
// Filename.swift


import Foundation
import Networking
import Core

protocol CharactersDependencyContainerType: DependencyType {
    var characterService: AppServiceType { get }
}

public final class CharactersDependencyContainer: CharactersDependencyContainerType {
    // Provide an APIService instance
    let apiService: APIServiceType = APIService()
    
    // Base URL for the API
    lazy var baseUrl: URL = {
        if let urlString = Bundle.main.object(forInfoDictionaryKey: "BaseUrl") as? String,
           let url = URL(string: urlString) {
            return url
        } else {
            fatalError("URL not found.")
        }
    }()
    
    // Provide the CharacterService dependency
    lazy var characterService: AppServiceType = {
        CharacterService(apiService: apiService, baseUrl: baseUrl)
    }()
}
