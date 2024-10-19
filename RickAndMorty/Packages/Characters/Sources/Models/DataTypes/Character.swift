//
// Character.swift


import Foundation

struct Character: Codable, Equatable {
    let id: Int
    let name: String
    let status: CharacterStatus
    let species: String
    let gender: CharacterGender
    let location: CharacterLocation
    let image: URL
    
    static func == (lhs: Character, rhs: Character) -> Bool {
        self == self
    }
}
