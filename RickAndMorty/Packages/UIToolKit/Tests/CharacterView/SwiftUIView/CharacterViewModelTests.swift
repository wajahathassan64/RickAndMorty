//
// CharacterViewModelTests.swift


import XCTest
import SwiftUI
@testable import UIToolKit

import XCTest
import SwiftUI

final class CharacterViewModelTests: XCTestCase {
    
    // MARK: - Constants
    private enum Constants {
        static let rickImageUrl = "https://rickandmortyapi.com/api/character/avatar/1.jpeg"
        static let mortyImageUrl = "https://rickandmortyapi.com/api/character/avatar/2.jpeg"
        static let jerryImageUrl = "https://rickandmortyapi.com/api/character/avatar/3.jpeg"
        static let rickName = "Rick Sanchez"
        static let mortyName = "Morty Smith"
        static let jerryName = "Jerry Smith"
        static let species = "Human"
        static let aliveStatus = "Alive"
        static let deadStatus = "Dead"
        static let unknownStatus = "Unknown"
    }
    
    // MARK: - Properties
    var viewModel: CharacterViewModel!
    
    // MARK: - TearDown
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    // MARK: - Helper Method
    private func createCharacterViewModel(
        imageUrl: URL? = nil,
        name: String = Constants.rickName,
        species: String = Constants.species,
        status: String = Constants.aliveStatus
    ) -> CharacterViewModel {
        return CharacterViewModel(
            charImageUrl: imageUrl,
            charName: name,
            charSpecies: species,
            charStatusString: status
        )
    }
    
    // MARK: - Tests
    func testViewModelInitialization_withAliveStatus() {
        // given
        let charImageUrl = URL(string: Constants.rickImageUrl)
        
        // when
        viewModel = createCharacterViewModel(imageUrl: charImageUrl, status: Constants.aliveStatus)
        
        // then
        XCTAssertEqual(viewModel.charName, Constants.rickName)
        XCTAssertEqual(viewModel.charSpecies, Constants.species)
        XCTAssertEqual(viewModel.charStatus, .alive)
        XCTAssertEqual(viewModel.charImageUrl, charImageUrl)
        XCTAssertEqual(viewModel.backgroundColor, Color.blue.opacity(0.15))
    }
    
    func testViewModelInitialization_withDeadStatus() {
        // given
        let charImageUrl = URL(string: Constants.mortyImageUrl)
        
        // when
        viewModel = createCharacterViewModel(imageUrl: charImageUrl, name: Constants.mortyName, status: Constants.deadStatus)
        
        // then
        XCTAssertEqual(viewModel.charName, Constants.mortyName)
        XCTAssertEqual(viewModel.charSpecies, Constants.species)
        XCTAssertEqual(viewModel.charStatus, .dead)
        XCTAssertEqual(viewModel.charImageUrl, charImageUrl)
        XCTAssertEqual(viewModel.backgroundColor, Color.red.opacity(0.15))
    }
    
    func testViewModelInitialization_withUnknownStatus() {
        // given
        let charImageUrl = URL(string: Constants.jerryImageUrl)
        
        // when
        viewModel = createCharacterViewModel(imageUrl: charImageUrl, name: Constants.jerryName, status: Constants.unknownStatus)
        
        // then
        XCTAssertEqual(viewModel.charName, Constants.jerryName)
        XCTAssertEqual(viewModel.charSpecies, Constants.species)
        XCTAssertEqual(viewModel.charStatus, .unknown)
        XCTAssertEqual(viewModel.charImageUrl, charImageUrl)
        XCTAssertEqual(viewModel.backgroundColor, Color.gray.opacity(0.15))
    }
    
    func testViewModelMock() {
        // when
        viewModel = CharacterViewModel.mock()
        
        // then
        XCTAssertEqual(viewModel.charName, Constants.rickName)
        XCTAssertEqual(viewModel.charSpecies, Constants.species)
        XCTAssertEqual(viewModel.charStatus, .alive)
        XCTAssertEqual(viewModel.charImageUrl, URL(string: Constants.rickImageUrl))
        XCTAssertEqual(viewModel.backgroundColor, Color.blue.opacity(0.15))
    }
}
