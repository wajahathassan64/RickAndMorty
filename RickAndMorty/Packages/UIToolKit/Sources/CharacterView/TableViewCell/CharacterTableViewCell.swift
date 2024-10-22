//
// CharacterTableViewCell.swift

import UIKit
import SwiftUI
import Core

public class CharacterTableViewCell: UITableViewCell {
    // MARK: - Properties
    private var viewModel: CharacterCellViewModelType!
    
    // MARK: - Configuration
    public override func configure(with viewModel: Any) {
        guard let viewModel = viewModel as? CharacterCellViewModelType else { return }
        self.viewModel = viewModel
        
        let view = CharacterView(viewModel: viewModel.characterViewModel)
        contentView.host(view)
        
        selectionStyle = .none
    }
}
