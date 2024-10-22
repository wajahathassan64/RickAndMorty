//
// CharacterViewModel.swift


import Foundation
import SwiftUI

enum CharacterStatusType {
    case alive
    case dead
    case unknown

    init(from externalStatus: String) {
        switch externalStatus {
        case "Alive":
            self = .alive
        case "Dead":
            self = .dead
        default:
            self = .unknown
        }
    }
}

protocol CharacterViewModelType: ObservableObject {
    var charImageUrl: URL? { get }
    var charName: String { get }
    var charSpecies: String { get }
    var backgroundColor: Color { get }
}

final class CharacterViewModel: CharacterViewModelType {
    @Published var charImageUrl: URL?
    @Published var charName: String
    @Published var charSpecies: String
    @Published var charStatus: CharacterStatusType

    init(charImageUrl: URL? = nil, charName: String, charSpecies: String, charStatusString: String) {
        self.charImageUrl = charImageUrl
        self.charName = charName
        self.charSpecies = charSpecies
        self.charStatus = CharacterStatusType(from: charStatusString)
    }

    var backgroundColor: Color {
        switch charStatus {
        case .alive:
            return Color.blue.opacity(0.3)
        case .dead:
            return Color.red.opacity(0.3)
        case .unknown:
            return Color.gray.opacity(0.3)
        }
    }
    
    static func mock() -> CharacterViewModel {
        return CharacterViewModel(
            charImageUrl: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"),
            charName: "Rick Sanchez",
            charSpecies: "Human", 
            charStatusString: "Alive"
        )
    }
}
