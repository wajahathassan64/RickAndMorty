//
// CharacterFilterView.swift


import SwiftUI

// MARK: - Filter Constants
private enum FilterConstants {
    static let buttonPadding: CGFloat = 16
    static let buttonSpacing: CGFloat = 16
    static let statusAlive = "Alive"
    static let statusDead = "Dead"
    static let statusUnknown = "Unknown"
}

// MARK: - Filter View
struct CharacterFilterView<ViewModel>: View where ViewModel: CharacterFilterViewModelType {
    // MARK: - Properties
    @StateObject private var viewModel: ViewModel
    
    // MARK: - Initializer
    init(viewModel: @autoclosure @escaping () -> ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel())
    }
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: FilterConstants.buttonSpacing) {
            FilterButton(
                action: {
                    viewModel.selectedFilter(with: FilterConstants.statusAlive)
                },
                title: FilterConstants.statusAlive,
                isEnabled: viewModel.isAliveEnabled
            )
            
            FilterButton(
                action: {
                    viewModel.selectedFilter(with: FilterConstants.statusDead)
                },
                title: FilterConstants.statusDead,
                isEnabled: viewModel.isDeadEnabled
            )
            
            FilterButton(
                action: {
                    viewModel.selectedFilter(with: FilterConstants.statusUnknown)
                },
                title: FilterConstants.statusUnknown,
                isEnabled: viewModel.isUnknownEnabled
            )
            
            Spacer()
        }
        .padding(.all, FilterConstants.buttonPadding)
    }
}

#Preview {
    CharacterFilterView(viewModel: CharacterFilterViewModel())
}
