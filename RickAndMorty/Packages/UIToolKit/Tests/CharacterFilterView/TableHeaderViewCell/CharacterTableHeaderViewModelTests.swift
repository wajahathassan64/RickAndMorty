//
// CharacterTableHeaderViewModelTests.swift


import XCTest

@testable import UIToolKit

final class CharacterTableHeaderViewModelTests: XCTestCase {
    
    var sut: CharacterTableHeaderViewModel!
    
    override func setUp() {
        super.setUp()
        sut = CharacterTableHeaderViewModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testFilterViewModelInitialization() {
        // then: The filterViewModel should not be nil
        XCTAssertNotNil(sut.filterViewModel, "The filterViewModel should be initialized")
    }
    
    func testReuseIdentifierIsSetCorrectly() {
        // given: The expected reuseIdentifier value
        let expectedReuseIdentifier = "CharacterTableHeaderView"
        
        // when: The view model is initialized
        // then: The reuseIdentifier should be set correctly
        XCTAssertEqual(sut.reuseIdentifier, expectedReuseIdentifier)
    }
}
