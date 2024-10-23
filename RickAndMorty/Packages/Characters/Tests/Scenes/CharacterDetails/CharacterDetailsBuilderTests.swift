//
// CharacterDetailsBuilderTests.swift


import XCTest
import SwiftUI
@testable import Characters

class CharacterDetailsBuilderTests: XCTestCase {
    // MARK: - Tests
    func testBuildCreatesUIHostingControllerForCharacterDetailsView() {
        let viewController = CharacterDetailsBuilder.build(character: MockCharacter.createMockCharacter(), actionCallback: nil)

        XCTAssertTrue(viewController is UIHostingController<CharacterDetailsView<CharacterDetailsViewModel>>)
    }

}
