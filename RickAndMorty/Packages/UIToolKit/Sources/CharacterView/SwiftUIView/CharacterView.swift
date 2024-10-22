//
// CharacterView.swift


import SwiftUI

// MARK: - Constants
struct CharacterViewConstants {
    struct Dimensions {
        static let imageHeight: CGFloat = 80
        static let imageWidth: CGFloat = 80
        static let padding: CGFloat = 16
        static let textTopPadding: CGFloat = 2
    }
    
    struct CornerRadii {
        static let view: CGFloat = 20
        static let image: CGFloat = 12
    }
    
    struct Borders {
        static let width: CGFloat = 1
        static let color = Color(red: 0.92, green: 0.92, blue: 0.92)
    }
}

struct CharacterView<ViewModel>: View where ViewModel: CharacterViewModelType {
    
    @StateObject private var viewModel: ViewModel
    
    init(viewModel: @autoclosure @escaping () -> ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel())
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, content: {
                HStack(alignment: .top, spacing: CharacterViewConstants.Dimensions.padding, content: {
                    if let url = viewModel.charImageUrl {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: CharacterViewConstants.Dimensions.imageWidth, height: CharacterViewConstants.Dimensions.imageHeight)
                                .clipped()
                                .cornerRadius(CharacterViewConstants.CornerRadii.image)
                                .transition(.opacity)
                        } placeholder: {
                            ProgressView()
                                .frame(width: CharacterViewConstants.Dimensions.imageWidth, height: CharacterViewConstants.Dimensions.imageHeight)
                        }
                        
                        VStack(alignment: .leading, spacing: .zero, content: {
                            Text(viewModel.charName)
                                .font(.title3)
                                .fontWeight(.medium)
                            Text(viewModel.charSpecies)
                                .font(.body)
                                .fontWeight(.thin)
                        })
                        .padding(.top, CharacterViewConstants.Dimensions.textTopPadding)
                        Spacer()
                    }
                })
            })
            .padding(.all, CharacterViewConstants.Dimensions.padding)
            .background(viewModel.backgroundColor)
            .cornerRadius(CharacterViewConstants.CornerRadii.view)
            .overlay(
                RoundedRectangle(cornerRadius: CharacterViewConstants.CornerRadii.view)
                    .stroke(CharacterViewConstants.Borders.color, lineWidth: CharacterViewConstants.Borders.width)
            )
        }
        .padding(.top, CharacterViewConstants.Dimensions.padding / 2)
        .padding(.leading, CharacterViewConstants.Dimensions.padding)
        .padding(.trailing, CharacterViewConstants.Dimensions.padding)
        .padding(.bottom, CharacterViewConstants.Dimensions.padding / 2)
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterView(viewModel: CharacterViewModel.mock())
    }
}
