//
// CharacterDetailsViewModelTests.swift


import XCTest

import XCTest
@testable import Characters

final class CharacterDetailsViewModelTests: XCTestCase {
    
    var sut: CharacterDetailsViewModel!
    var mockCharacter: Character!
    
    // MARK: - Setup
    override func setUp() {
        super.setUp()
        mockCharacter = MockCharacter.createMockCharacter()
        sut = CharacterDetailsViewModel(with: mockCharacter, actionCallback: nil)
    }

    // MARK: - Tear down
    override func tearDown() {
        sut = nil
        mockCharacter = nil
        super.tearDown()
    }

    func testCharacterDetailsViewModelInitialization() {
        // given
        let character = mockCharacter!
        
        // when
        let viewModel = CharacterDetailsViewModel(with: character, actionCallback: nil)
        
        // then
        XCTAssertEqual(viewModel.name, character.name)
        XCTAssertEqual(viewModel.species, character.species)
        XCTAssertEqual(viewModel.gender, "Male")
        XCTAssertEqual(viewModel.status, "Alive")
        XCTAssertEqual(viewModel.location, character.location.name)
        XCTAssertEqual(viewModel.imageUrl, character.image)
    }
    
    func testOnTapBackTriggersCallback() {
        // given
        var callbackAction: CharacterDetailsAction?
        let character = mockCharacter!
        let expectation = XCTestExpectation(description: "Action Callback is triggered")
        
        let viewModel = CharacterDetailsViewModel(with: character) { action in
            callbackAction = action
            expectation.fulfill()
        }
        
        // when
        viewModel.onTapBack()
        
        // then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(callbackAction is CharacterDetailsViewModel.BackAction)
    }
}
