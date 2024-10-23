//
// CharacterService.swift


import Foundation
import Networking
public typealias Success<T: Decodable> = (T) -> Void
public typealias Failure = (Error) -> Void

public protocol AppServiceType {
    func getCharacters(for page: Int, status: CharacterStatus?) async -> Result<CharactersResponse, Error>
}

final class CharacterService: AppServiceType {
    
    let apiService: APIServiceType
    let baseUrl: URL
    
    init(apiService: APIServiceType, baseUrl: URL) {
        self.apiService = apiService
        self.baseUrl = baseUrl
    }
    
    func getCharacters(for page: Int, status: CharacterStatus?) async -> Result<CharactersResponse, Error> {
        var query = ["page": "\(page)"]
        if let status = status {
            query["status"] = status.rawValue.lowercased()
        }
        
        let endpoint = Endpoint(baseURL: baseUrl, path: "/character", method: .GET, queryParams: query)

        return await withCheckedContinuation { continuation in
            apiService.request(endpoint: endpoint) { (result: Result<CharactersResponse, NetworkError>) in
                switch result {
                case .success(let response):
                    continuation.resume(returning: .success(response))
                case .failure(let error):
                    continuation.resume(returning: .failure(error))
                }
            }
        }
    }
}
