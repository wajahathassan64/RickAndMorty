//
// MockCharacterService.swift


import Foundation
@testable import Characters

class MockCharacterService: AppServiceType {
    var mockCharacters: [Character]?
    var mockInfo: Info = Info(count: 100, pages: 10, next: "https://api.yourservice.com/next", prev: "https://api.yourservice.com/prev")
    var didFetchCharacters = false
    
    func getCharacters(for page: Int, status: CharacterStatus?) async -> Result<CharactersResponse, Error> {
        didFetchCharacters = true
        
        if let characters = mockCharacters {
            let response = CharactersResponse(info: mockInfo, results: characters)
            return .success(response)
        } else {
            return .failure(NSError(domain: "MockError", code: -1, userInfo: [NSLocalizedDescriptionKey: "No characters available"]))
        }
    }
}
