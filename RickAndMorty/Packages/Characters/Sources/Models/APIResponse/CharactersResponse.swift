//
// CharactersResponse.swift


import Foundation

public struct CharactersResponse: Codable, Equatable {
    let info: Info
    let results: [Character]
    
    public static func == (lhs: CharactersResponse, rhs: CharactersResponse) -> Bool {
        lhs.results == rhs.results
    }
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
