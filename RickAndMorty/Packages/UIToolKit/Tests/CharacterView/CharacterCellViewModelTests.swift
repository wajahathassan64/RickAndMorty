//
// CharacterCellViewModelTests.swift


import XCTest

@testable import UIToolKit

final class CharacterCellViewModelTests: XCTestCase {

    var sut: CharacterCellViewModel!
    
    // MARK: - Test Data
    let testCharImageUrl = URL(string: "https://example.com/character.png")
    let testCharName = "Rick Sanchez"
    let testCharSpecies = "Human"
    let testCharStatusString = "Alive"
    
    override func setUp() {
        super.setUp()
        sut = CharacterCellViewModel(
            charImageUrl: testCharImageUrl,
            charName: testCharName,
            charSpecies: testCharSpecies,
            charStatusString: testCharStatusString
        )
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testReuseIdentifierIsSetCorrectly() {
        let expectedReuseIdentifier = "CharacterTableViewCell"
        XCTAssertEqual(sut.reuseIdentifier, expectedReuseIdentifier, "The reuseIdentifier should match the expected value")
    }

    func testCharacterViewModelInitialization() {
        let testCharStatusString = CharacterStatusType(from: testCharStatusString)
        XCTAssertEqual(sut.characterViewModel.charName, testCharName)
        XCTAssertEqual(sut.characterViewModel.charSpecies, testCharSpecies)
        XCTAssertEqual(sut.characterViewModel.charStatus, testCharStatusString)
        XCTAssertEqual(sut.characterViewModel.charImageUrl, testCharImageUrl)
    }
}
