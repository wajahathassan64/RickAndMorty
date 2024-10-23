//
// RMCharacterStatus.swift


import Foundation
public enum CharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case `unknown` = "unknown"
    
    var text: String {
        switch self {
        case .alive, .dead:
            return rawValue
        case .unknown:
            return "Unknown"
        }
    }
    
    init?(from string: String) {
        let lowercasedString = string.lowercased()
        switch lowercasedString {
        case "alive":
            self = .alive
        case "dead":
            self = .dead
        case "unknown":
            self = .unknown
        default:
            return nil
        }
    }
}
