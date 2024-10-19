//
// NetworkingErrorTests.swift

import XCTest
@testable import Networking

class NetworkErrorTests: XCTestCase {

    func testInvalidURLError() {
        let error: NetworkError = .invalidURL
        XCTAssertEqual(error, .invalidURL)
    }
    
    func testNetworkError() {
        let underlyingError = NSError(domain: "NetworkErrorDomain", code: -1001, userInfo: nil)
        let error: NetworkError = .networkError(underlyingError)
        
        switch error {
        case .networkError(let receivedError):
            XCTAssertEqual(receivedError as NSError, underlyingError)
        default:
            XCTFail("Expected networkError case")
        }
    }
    
    func testServerError() {
        let error: NetworkError = .serverError
        XCTAssertEqual(error, .serverError)
    }
    
    func testNoDataError() {
        let error: NetworkError = .noData
        XCTAssertEqual(error, .noData)
    }
    
    func testDecodingError() {
        let underlyingError = NSError(domain: "DecodingErrorDomain", code: -1002, userInfo: nil)
        let error: NetworkError = .decodingError(underlyingError)
        
        switch error {
        case .decodingError(let receivedError):
            XCTAssertEqual(receivedError as NSError, underlyingError)
        default:
            XCTFail("Expected decodingError case")
        }
    }
}

