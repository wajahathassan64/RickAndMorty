//
// CharacterServiceTests.swift


import XCTest
@testable import Characters
@testable import Networking

final class CharacterServiceTests: XCTestCase {
    
    var sut: CharacterService!
    var mockApiService: MockAPIService!
    var mockBaseUrl: URL!
    
    override func setUp() {
        super.setUp()
        mockApiService = MockAPIService()
        mockBaseUrl = URL(string: "https://mockapi.com")!
        sut = CharacterService(apiService: mockApiService, baseUrl: mockBaseUrl)
    }
    
    override func tearDown() {
        mockApiService = nil
        mockBaseUrl = nil
        sut = nil
        super.tearDown()
    }
    
    func testGetCharacterList() async {
        // Given
        let mockCharactersResponse = CharacterServiceTests.mockCharacterResponse()
        mockApiService.result = .success(mockCharactersResponse)
        
        // When
        let result = await sut.getCharacters(for: 1, status: .alive)
        
        // Then
        switch result {
        case .success(let response):
            XCTAssertEqual(response.results.count, 2, "Expected 2 characters in the response")
            XCTAssertEqual(response, mockCharactersResponse, "Expected response to match the mock response")
        case .failure(let error):
            XCTFail("Expected success but got error: \(error)")
        }
    }
    
    func testGetCharacterListEmptyResponse() async {
        // Given
        let mockEmptyResponse = CharactersResponse(
            info: Info(count: 0, pages: 0, next: nil, prev: nil),
            results: []
        )
        
        mockApiService.result = .success(mockEmptyResponse)
        
        // When
        let result = await sut.getCharacters(for: 1, status: .alive)
        
        // Then
        switch result {
        case .success(let response):
            XCTAssertEqual(response.results.count, 0, "Expected empty character list")
            XCTAssertEqual(response, mockEmptyResponse, "Expected response to match the mock empty response")
        case .failure(let error):
            XCTFail("Expected success but got error: \(error)")
        }
    }
    
    func testGetCharacterListNetworkError() async {
        // Given
        let mockError: NetworkError = .networkError(NSError(domain: "test", code: -1, userInfo: nil))
        mockApiService.result = .failure(mockError)
        
        // When
        let result = await sut.getCharacters(for: 1, status: .alive)
        
        // Then
        switch result {
        case .success(let response):
            XCTFail("Expected to fail, but got a successful response: \(response)")
        case .failure(let error):
            XCTAssertEqual(error as? NetworkError, mockError, "Expected the thrown error to match the mock error")
        }
    }
}

extension CharacterServiceTests {
    static func mockCharacterResponse() -> CharactersResponse {
        return CharactersResponse(
            info: Info(
                count: 2,
                pages: 1,
                next: nil,
                prev: nil
            ),
            results: [
                Character(
                    id: 1,
                    name: "Rick Sanchez",
                    status: .alive,
                    species: "Human",
                    gender: .male,
                    location: CharacterLocation(name: "Earth"),
                    image: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!
                ),
                Character(
                    id: 2,
                    name: "Morty Smith",
                    status: .alive,
                    species: "Human",
                    gender: .male,
                    location: CharacterLocation(name: "Earth"),
                    image: URL(string: "https://rickandmortyapi.com/api/character/avatar/2.jpeg")!
                )
            ]
        )
    }
}
