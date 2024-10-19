//
// RMCharacter.swift


import Foundation

struct RMCharacter: Codable {
    let id: Int
    let name: String
    let status: RMCharacterStatus
    let species: String
    let gender: RMCharacterGender
    let location: RMCharacterLocation
    let image: URL
}
