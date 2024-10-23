//
// FilterButton.swift

import Foundation
import SwiftUI

// MARK: - Filter Button Constants
private enum FilterButtonConstants {
    static let height: CGFloat = 40
    static let buttonPadding: CGFloat = 16
    static let buttonSpacing: CGFloat = 16
}

// MARK: - Filter Button View
struct FilterButton: View {
    // MARK: - Properties
    var action: () -> Void
    var title: String
    var isEnabled: Bool = false
    
    @Environment(\.colorScheme) var colorScheme
    
    // MARK: - Body
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.body)
                .fontWeight(.medium)
                .padding(.leading, FilterButtonConstants.buttonPadding)
                .padding(.trailing, FilterButtonConstants.buttonPadding)
        }
        .frame(height: FilterButtonConstants.height, alignment: .center)
        .foregroundColor(isEnabled ? buttonColors.light : buttonColors.dark)
        .background(
            isEnabled ? buttonColors.dark : buttonColors.light,
            in: Capsule()
        )
        .overlay(
            Capsule().stroke(isEnabled ? Color.black : Color.gray, lineWidth: 1)
        )
    }
    
    private var buttonColors: (light: Color, dark: Color) {
        switch colorScheme {
        case .light:
            return (light: Color.clear, dark: Color.black)
        case .dark:
            return (light: Color.clear, dark: Color.white)
        @unknown default:
            return (light: Color.clear, dark: Color.black)
        }
    }
}
