//
// CharacterDetailsBuilder.swift


import Foundation
import SwiftUI

class CharacterDetailsBuilder {
    class func build(character: Character, actionCallback: CharacterDetailsActionCallback?) -> UIViewController {
        let viewModel = CharacterDetailsViewModel(with: character, actionCallback: actionCallback)
        return UIHostingController(rootView: CharacterDetailsView(viewModel: viewModel))
    }
}
