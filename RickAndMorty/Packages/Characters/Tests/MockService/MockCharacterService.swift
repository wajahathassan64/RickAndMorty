//
// MockCharacterService.swift


import Foundation
@testable import Characters

class MockCharacterService: AppServiceType {
    var didCallGetCharacters = false
    var mockCharacters: [Character]?
    var mockInfo: Info = Info(count: 100, pages: 10, next: "https://api.yourservice.com/next", prev: "https://api.yourservice.com/prev")
    
    func getCharacters(for page: Int, status: CharacterStatus?, onSuccess: @escaping (CharactersResponse) -> Void, onFailure: @escaping (Error) -> Void) {
        didCallGetCharacters = true
        
        if let characters = mockCharacters {
            let response = CharactersResponse(info: mockInfo, results: characters)
            onSuccess(response)
        } else {
            onFailure(NSError(domain: "", code: -1, userInfo: nil))
        }
    }
}


