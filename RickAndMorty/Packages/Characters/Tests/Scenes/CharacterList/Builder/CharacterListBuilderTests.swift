//
// CharacterListBuilderTests.swift


import XCTest
@testable import Characters

final class CharacterListBuilderTests: XCTestCase {
    // MARK: - Tests
    func testBuilderCharacterListViewController() {
        // given
        let mockApiService = MockAPIService()
        let mockBaseUrl = URL(string: "https://mockapi.com")!
        let mockCharactersDependencyContainer: CharactersDependencyContainerType = MockCharactersDependencyContainer(characterService: CharacterService(apiService: mockApiService, baseUrl: mockBaseUrl))
        // when
        let viewController = CharacterListBuilder.build(dependency: mockCharactersDependencyContainer, actionCallback: nil)
        
        // then
        XCTAssertTrue(viewController is CharacterListViewController)
    }
}
