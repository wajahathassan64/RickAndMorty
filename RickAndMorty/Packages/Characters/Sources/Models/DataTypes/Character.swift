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
        return lhs.name == rhs.name
        && lhs.status == rhs.status
        && lhs.species == rhs.species
        && lhs.gender == rhs.gender
        && lhs.image.absoluteString == rhs.image.absoluteString
        && lhs.location.name == rhs.location.name
    }
}
