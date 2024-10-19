//
// CharacterService.swift


import Foundation
import Networking

public typealias Success<T: Decodable> = (T) -> Void
public typealias Failure = (Error) -> Void

protocol AppServiceType {
    func getCharacters(for page: Int, status: CharacterStatus?, onSuccess: @escaping Success<CharactersResponse>, onFailure: @escaping Failure )
}

final class CharacterService: AppServiceType {
    
    let apiService: APIServiceType
    let baseUrl: URL
    
    init(apiService: APIServiceType, baseUrl: URL) {
        self.apiService = apiService
        self.baseUrl = baseUrl
    }
    
    func getCharacters(for page: Int, status: CharacterStatus?, onSuccess: @escaping Success<CharactersResponse>, onFailure: @escaping Failure) {
        
        var query = ["page": "\(page)"]
        if let status = status {
            query["status"] = status.rawValue.lowercased()
        }
        
        let endpoint = Endpoint(baseURL: baseUrl, path: "", method: .PUT, queryParams: query)
        
        apiService.request(endpoint: endpoint) { (result: Result<CharactersResponse, NetworkError>) in
            switch result {
            case .success(let result):
                onSuccess(result)
            case .failure(let error):
                onFailure(error)
            }
            
        }
    }
    
}
