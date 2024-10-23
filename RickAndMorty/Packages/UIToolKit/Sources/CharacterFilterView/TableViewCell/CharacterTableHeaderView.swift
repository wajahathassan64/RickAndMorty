//
// CharacterTableHeaderView.swift


import Foundation
import SwiftUI

public final class CharacterTableHeaderView: UITableViewHeaderFooterView {
    // MARK: - Properties
    private var viewModel: CharacterTableHeaderViewModelType!
    
    // MARK: - Configuration
    public override func configure(with viewModel: Any) {
        guard let viewModel = viewModel as? CharacterTableHeaderViewModelType else { return }
        self.viewModel = viewModel
        contentView.host(CharacterFilterView(viewModel: viewModel.filterViewModel))
    }
}
