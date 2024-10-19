//
// MockAPIService.swift

import Foundation
@testable import Networking

class MockAPIService: APIServiceType {
    
    var mockData: Data?
    var mockError: NetworkError?
    var mockResponse: URLResponse?
    
    func request<T: Decodable>(
        endpoint: Endpoint,
        completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        // Simulate a delay to mimic network latency
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) {
            
            // Check for an error case
            if let mockError = self.mockError {
                completion(.failure(mockError))
                return
            }
            
            // Check for valid data
            if let mockData = self.mockData {
                if T.self == Data.self {
                    completion(.success(mockData as! T))
                } else {
                    do {
                        let decoded = try JSONDecoder().decode(T.self, from: mockData)
                        completion(.success(decoded))
                    } catch {
                        completion(.failure(.decodingError(error)))
                    }
                }
            } else {
                completion(.failure(.noData))
            }
        }
    }
}
