//
// CharacterListViewModelTests.swift


import XCTest
@testable import Characters

final class CharacterListViewModelTests: XCTestCase {

    // MARK: - Properties
    var sut: CharacterListViewModel!
    var mockService: MockCharacterService!
    
    override func setUp() {
        super.setUp()
        mockService = MockCharacterService()
        sut = CharacterListViewModel(service: mockService, actionCallback: nil)
    }
    
    // MARK: - Tear down
    override func tearDown() {
        sut = nil
        mockService = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    func testNumberOfSections_shouldBeOne() {
        XCTAssertEqual(sut.numberOfSections, 1)
    }

    
}
