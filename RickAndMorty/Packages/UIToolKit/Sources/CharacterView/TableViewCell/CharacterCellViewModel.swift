//
// CharacterCellViewModel.swift


import Foundation
import Core

protocol CharacterCellViewModelType: ReusableCellViewModelType {
    var characterViewModel: CharacterViewModel { get }
}

public final class CharacterCellViewModel: CharacterCellViewModelType {
    // MARK: - Properties
    public var reuseIdentifier: String { CharacterTableViewCell.reuseIdentifier }
    var characterViewModel: CharacterViewModel
    
    // MARK: - Initializer
    public init(charImageUrl: URL? = nil, charName: String, charSpecies: String, charStatusString: String) {
        characterViewModel = CharacterViewModel(
            charImageUrl: charImageUrl,
            charName: charName,
            charSpecies: charSpecies,
            charStatusString: charStatusString
        )
    }
}
