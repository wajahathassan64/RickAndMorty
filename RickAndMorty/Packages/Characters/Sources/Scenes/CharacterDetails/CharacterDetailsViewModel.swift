//
// CharacterDetailsViewModel.swift

import Foundation

protocol CharacterDetailsAction {
    func execute(on flowController: CharactersFlowController)
}


typealias CharacterDetailsActionCallback = (CharacterDetailsAction) -> Void

protocol CharacterDetailsViewModelType: ObservableObject {
    var imageUrl: URL? { get }
    var name: String { get }
    var species: String { get }
    var gender: String { get }
    var status: String { get }
    var location: String { get }
    
    func onTapBack()
}

final class CharacterDetailsViewModel: CharacterDetailsViewModelType {
    // MARK: - Properties
    @Published var imageUrl: URL?
    @Published var name: String
    @Published var species: String
    @Published var gender: String
    @Published var status: String
    @Published var location: String
    
    private let actionCallback: CharacterDetailsActionCallback?
    
    // MARK: - Initialization
    init(
        with character: Character,
        actionCallback: CharacterDetailsActionCallback?
    ) {
        imageUrl = character.image
        name = character.name
        species = character.species
        gender = character.gender.rawValue.capitalized
        status = character.status.rawValue.capitalized
        location = character.location.name
        
        self.actionCallback = actionCallback
    }
    
    func onTapBack() {
        let backAction = BackAction()
        actionCallback?(backAction)
    }
}

extension CharacterDetailsViewModel {
    struct BackAction: CharacterDetailsAction {
        func execute(on flowController: CharactersFlowController) {
            flowController.navigateBackFromDetails()
        }
    }
}
