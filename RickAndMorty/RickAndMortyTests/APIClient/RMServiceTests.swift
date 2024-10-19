//
// RMServiceTests.swift


import XCTest
@testable import RickAndMorty

final class RMServiceTests: XCTestCase {
    
    var sut: RMService!
    var mockApiService: MockAPIService!
    
    override func setUp() {
        super.setUp()
        mockApiService = MockAPIService()
        sut = RMService(apiService: mockApiService)
    }

    override func tearDown() {
        mockApiService = nil
        sut = nil
        super.tearDown()
    }
    
}
