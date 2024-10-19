//
// RMAService.swift


import Foundation
import Networking

protocol AppServiceType {
    func getCharacters(for page: Int, status: RMCharacterStatus, onSuccess: @escaping Success<RMGetAllCharactersResponse>, onFailure: @escaping Failure )
}


final class RMService: Service {
    
    private let apiClient: APIClientType
    
    init(apiClient: APIClientType = APIClient()) {
        self.apiClient = apiClient
    }
    
}
