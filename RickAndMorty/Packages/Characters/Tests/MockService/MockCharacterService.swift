//
// MockCharacterService.swift


import Foundation
@testable import Characters

class MockCharacterService: AppServiceType {
    
    var mockCharacters: [Character]?
    var mockInfo: Info = Info(count: 100, pages: 10, next: "https://api.yourservice.com/next", prev: "https://api.yourservice.com/prev")
    var didFetchCharacters = false
    
    func getCharacters(for page: Int, status: CharacterStatus?) async throws -> CharactersResponse {
        didFetchCharacters = true
        
        if let characters = mockCharacters {
            let response = CharactersResponse(info: mockInfo, results: characters)
            return response
        } else {
            throw NSError(domain: "", code: -1, userInfo: nil)
        }
    }
}


