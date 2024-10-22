//
// CharacterService.swift


import Foundation
import Networking

public protocol AppServiceType {
    func getCharacters(for page: Int, status: CharacterStatus?) async throws -> CharactersResponse
}

final class CharacterService: AppServiceType {
    
    let apiService: APIServiceType
    let baseUrl: URL
    
    init(apiService: APIServiceType, baseUrl: URL) {
        self.apiService = apiService
        self.baseUrl = baseUrl
    }
    
    func getCharacters(for page: Int, status: CharacterStatus?) async throws -> CharactersResponse {
        
        var query = ["page": "\(page)"]
        if let status = status {
            query["status"] = status.rawValue.lowercased()
        }
        
        let endpoint = Endpoint(baseURL: baseUrl, path: "/character", method: .PUT, queryParams: query)
        
        return try await withCheckedThrowingContinuation { continuation in
            apiService.request(endpoint: endpoint) { (result: Result<CharactersResponse, NetworkError>) in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
