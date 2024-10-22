//
// MockCharacter.swift


import Foundation
@testable import Characters

struct MockCharacter {
    static func createMockCharacter() -> Character {
        return Character(
            id: 1,
            name: "Rick Sanchez",
            status: .alive,
            species: "Human",
            gender: .male,
            location: CharacterLocation(name: "Earth"),
            image: URL(string: "www.example.com/img.jpg")!
        )
    }
    
    static func createMockCharacterList(count: Int) -> [Character] {
        return (1...count).map { index in
            return Character(
                id: index,
                name: "Character \(index)",
                status: .alive,
                species: "Human",
                gender: .male,
                location: CharacterLocation(name: "Location \(index)"),
                image: URL(string: "https://example.com/image/character\(index).png")!
            )
        }
    }
}

extension Info {
    static func stub(
        count: Int = 0,
        pages: Int = 0,
        next: String? = nil,
        prev: String? = nil
    ) -> Info {
        return Info(count: count, pages: pages, next: next, prev: prev)
    }
}
