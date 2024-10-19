//
// RMServiceTests.swift


import XCTest
@testable import RickAndMorty

final class RMServiceTests: XCTestCase {
    
    var sut: RMService!
    var apiClient: MockAPIClient!
    
    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
        sut = RMService(apiClient: apiClient)
    }

    override func tearDown() {
        apiClient = nil
        sut = nil
        super.tearDown()
    }

}
