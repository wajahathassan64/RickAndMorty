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
        mockBaseUrl = URL(string: "https://mockapi.com")
        sut = CharacterService(apiService: mockApiService, baseUrl: mockBaseUrl)
    }
    
    override func tearDown() {
        mockApiService = nil
        mockBaseUrl = nil
        sut = nil
        super.tearDown()
    }
    
    func testGetCharacterList() async throws {
        // given
        let mockCharactersResponse = CharacterServiceTests.mockCharacterResponse()
        mockApiService.result = .success(mockCharactersResponse)
        
        // when
        let response = try await sut.getCharacters(for: 1, status: .alive)
        
        // then
        XCTAssertEqual(response.results.count, 2)
        XCTAssertEqual(response, mockCharactersResponse)
    }
    
    func testGetCharacterListEmptyResponse() async throws {
        // given
        let mockEmptyResponse = CharactersResponse(
            info: Info(count: 0, pages: 0, next: nil, prev: nil),
            results: []
        )
        
        mockApiService.result = .success(mockEmptyResponse)
        
        // when
        let response = try await sut.getCharacters(for: 1, status: .alive)
        
        // then
        XCTAssertEqual(response.results.count, 0, "Expected empty character list")
        XCTAssertEqual(response, mockEmptyResponse)
    }
    
    func testGetCharacterListNetworkError() async throws {
        // given
        let mockError: NetworkError = .networkError(NSError(domain: "test", code: -1, userInfo: nil))
        mockApiService.result = .failure(mockError)
        
        do {
            // when
            _ = try await sut.getCharacters(for: 1, status: .alive)
            XCTFail("Expected to throw, but it did not throw")
        } catch {
            // then
            XCTAssertEqual(error as? NetworkError, mockError)
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
