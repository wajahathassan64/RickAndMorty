//
// NetworkError.swift


import Foundation

public enum NetworkError: Error {
    case invalidURL
    case networkError(Error)
    case serverError
    case noData
    case decodingError(Error)
}

extension NetworkError: Equatable {
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL),
            (.serverError, .serverError),
            (.noData, .noData):
            return true
        case (.networkError, .networkError),
            (.decodingError, .decodingError):
            return true // Ignore associated Error values
        default:
            return false
        }
    }
}
