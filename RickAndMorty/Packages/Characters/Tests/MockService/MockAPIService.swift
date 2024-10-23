//
// MockAPIService.swift

import Foundation
@testable import Characters
@testable import Networking

class MockAPIService: APIServiceType {
    var result: Result<CharactersResponse, NetworkError>?
    
    func request<T: Decodable>(
        endpoint: Endpoint,
        completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        if let result = result as? Result<T, NetworkError> {
            completion(result)
        }
    }
}
