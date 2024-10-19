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
    
    func testGetCharacterList() {
        // given
        let mockCharactersResponse = CharacterServiceTests.mockCharacterResponse()
        mockApiService.result =  .success(mockCharactersResponse)
        let characterListExpectation = expectation(description: "Character list fetched successfully")
        
        var response: CharactersResponse?
        
        let success: Success<CharactersResponse> = { result in
            response = result
            characterListExpectation.fulfill()
        }
        
        let failure: Failure = { _ in }
        
        // when
        sut.getCharacters(for: 1, status: .alive, onSuccess: success, onFailure: failure)
        
        // then
        wait(for: [characterListExpectation], timeout: 1.0)
        XCTAssertEqual(response?.results.count, 2)
        XCTAssertEqual(response, mockCharactersResponse)
        
    }
    
    func testGetCharacterListEmptyResponse() {
        // given
        let mockEmptyResponse = CharactersResponse(
            info: Info(count: 0, pages: 0, next: nil, prev: nil),
            results: []
        )
        
        let emptyCharacterListExpectation = self.expectation(description: "Empty character list fetched")
        
        mockApiService.result = .success(mockEmptyResponse)
        
        var response: CharactersResponse?
        
        let success: Success<CharactersResponse> = { result in
            response = result
            emptyCharacterListExpectation.fulfill()
        }
        
        let failure: Failure = { _ in }
        
        // when
        sut.getCharacters(for: 1, status: .alive, onSuccess: success, onFailure: failure)
        
        // then
        wait(for: [emptyCharacterListExpectation], timeout: 1.0)
        XCTAssertEqual(response?.results.count, 0, "Expected empty character list")
        XCTAssertEqual(response, mockEmptyResponse)
    }
    
    func testGetCharacterListNetworkError() {
        // given
        let mockError: NetworkError = .networkError(NSError(domain: "test", code: -1, userInfo: nil))
        mockApiService.result = .failure(mockError)
        
        let networkErrorExpectation = self.expectation(description: "Network error occurred")
        var fetchedError: NetworkError?
        
        let success: Success<CharactersResponse> = { _ in }
        
        let failure: Failure = { error in
            fetchedError = error as? NetworkError
            networkErrorExpectation.fulfill()
        }
        
        // when
        sut.getCharacters(for: 1, status: .alive, onSuccess: success, onFailure: failure)
        
        // then
        wait(for: [networkErrorExpectation], timeout: 1.0)
        XCTAssertNotNil(fetchedError)
        XCTAssertEqual(fetchedError, .networkError(mockError as NSError))
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
