//
// APIServiceTests.swift

import XCTest
@testable import Networking

class APIClientTests: XCTestCase {
    var sut: APIServiceType!
    var mockSession: MockURLSession!
    
    private struct Constants {
        static let baseUrl = URL(string: "https://api.example.com")!
    }
    
    override func setUp() {
        super.setUp()
        mockSession = MockURLSession()
        sut = APIService(session: mockSession)
    }
    
    override func tearDown() {
        sut = nil
        mockSession = nil
        super.tearDown()
    }
    
    func testRequestSuccess() {
        // Given
        let expectedData = "{\"message\": \"Success\"}".data(using: .utf8)!
        mockSession.data = expectedData
        mockSession.response = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        mockSession.error = nil
        
        let endpoint = Endpoint(baseURL: Constants.baseUrl, path: "", method: .GET, headers: nil)
        let expectation = self.expectation(description: "Completion handler invoked")
        var result: Result<MockResponse, NetworkError>?

        // When
        sut.request(endpoint: endpoint) { (response: Result<MockResponse, NetworkError>) in
            result = response
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 0.1)
        switch result {
        case .success(let data)?:
            XCTAssertEqual(data.message, "Success")
        case .failure(_)?:
            XCTFail("Expected success but got failure")
        case .none:
            XCTFail("Completion handler not invoked")
        }
    }
    
    func testRequestWithNetworkError() {
        // Given
        mockSession.error = NSError(domain: "network", code: -1001, userInfo: nil)
        let endpoint = Endpoint(baseURL: Constants.baseUrl, path: "", method: .GET, headers: nil)
        let expectation = self.expectation(description: "Completion handler invoked")
        var result: Result<Data, NetworkError>?

        // When
        sut.request(endpoint: endpoint) { (response: Result<Data, NetworkError>) in
            result = response
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 0.1)
        if case .failure(let error)? = result {
            XCTAssertEqual(error, .networkError(mockSession.error!))
        } else {
            XCTFail("Expected network error")
        }
    }
    
    func testRequestWithServerError() {
        // Given
        mockSession.response = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)
        let endpoint = Endpoint(baseURL: Constants.baseUrl, path: "", method: .GET, headers: nil)
        let expectation = self.expectation(description: "Completion handler invoked")
        var result: Result<Data, NetworkError>?

        // When
        sut.request(endpoint: endpoint) { (response: Result<Data, NetworkError>) in
            result = response
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 0.1)
        if case .failure(let error)? = result {
            XCTAssertEqual(error, .serverError)
        } else {
            XCTFail("Expected server error")
        }
    }
    
    func testRequestWithNoData() {
        // Given
        mockSession.response = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        mockSession.data = nil
        let endpoint = Endpoint(baseURL: Constants.baseUrl, path: "", method: .GET, headers: nil)
        let expectation = self.expectation(description: "Completion handler invoked")
        var result: Result<Data, NetworkError>?

        // When
        sut.request(endpoint: endpoint) { (response: Result<Data, NetworkError>) in
            result = response
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 0.1)
        if case .failure(let error)? = result {
            XCTAssertEqual(error, .noData)
        } else {
            XCTFail("Expected no data error")
        }
    }
    
    func testRequestWithDecodingError() {
        // Given
        let invalidData = "invalid json".data(using: .utf8)!
        mockSession.data = invalidData
        mockSession.response = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        mockSession.error = nil
        
        let endpoint = Endpoint(baseURL: Constants.baseUrl, path: "", method: .GET, headers: nil)
        let expectation = self.expectation(description: "Completion handler invoked")
        var result: Result<MockResponse, NetworkError>?

        // When
        sut.request(endpoint: endpoint) { (response: Result<MockResponse, NetworkError>) in
            result = response
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 0.1)
        if case .failure(let error)? = result {
            if case .decodingError(let decodingError) = error {
                XCTAssertTrue(decodingError is DecodingError)
            } else {
                XCTFail("Expected decoding error")
            }
        } else {
            XCTFail("Expected failure result")
        }
    }
}

// Example response model for decoding
struct MockResponse: Decodable {
    let message: String
}
