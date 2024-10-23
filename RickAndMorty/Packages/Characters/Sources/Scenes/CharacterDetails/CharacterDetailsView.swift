//
// CharacterDetailsView.swift


import Foundation
import SwiftUI

private enum Constant {
    static let padding: CGFloat = 16
    static let verticalSpacing: CGFloat = 12
    static let imageCornerRadius: CGFloat = 25
    static let backIcon = "arrow.backward.circle.fill"
    static let backIconSize: CGFloat = 44
    static let horizontalSpacing: CGFloat = 4
    static let statusSize = CGSize(width: 100, height: 35)
    static let separator = "•"
    static let location = "Location :"
}

struct CharacterDetailsView<ViewModel>: View where ViewModel: CharacterDetailsViewModelType {
    // MARK: - Properties
    @StateObject private var viewModel: ViewModel
    
    // MARK: - Initializer
    init(viewModel: @autoclosure @escaping () -> ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel())
    }
    
    // MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: Constant.verticalSpacing, content: {
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .top), content: {
                    
                    AsyncImage(url: viewModel.imageUrl) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .aspectRatio(1, contentMode: .fit)
                            
                    } placeholder: {
                        ProgressView()
                            .padding(.top, geometry.safeAreaInsets.top)
                    }
                    .frame(maxWidth: .infinity)
                    
                    .cornerRadius(Constant.imageCornerRadius, corners: [.bottomLeft, .bottomRight])
                    
                    Button(action: {
                        viewModel.onTapBack()
                    }) {
                        Image(systemName: Constant.backIcon)
                            .resizable()
                            .tint(.white)
                            .frame(width: Constant.backIconSize, height: Constant.backIconSize)
                        
                    }
                    .padding(.leading, Constant.padding)
                    .padding(.top, geometry.safeAreaInsets.top)
                })
                
                VStack(alignment: .leading, spacing: Constant.verticalSpacing, content: {
                    HStack(alignment: .center, content: {
                        VStack(alignment: .leading, spacing: .zero, content: {
                            Text(viewModel.name)
                                .font(.title2)
                                .fontWeight(.medium)
                            
                            HStack(alignment: .center, spacing: Constant.horizontalSpacing, content: {
                                Text(viewModel.species)
                                    .font(.body)
                                    .fontWeight(.regular)
                                
                                Text(Constant.separator)
                                    .font(.body)
                                    .fontWeight(.heavy)
                                
                                Text(viewModel.gender)
                                    .font(.body)
                                    .fontWeight(.thin)
                            })
                        })
                        
                        Spacer()
                        
                        Text(viewModel.status)
                            .frame(width: Constant.statusSize.width, height: Constant.statusSize.height, alignment: .center)
                            .background(Color.blue)
                            .clipShape(Capsule())
                            .foregroundStyle(.white)
                            .font(.body)
                    })
                    
                    HStack(alignment: .center, content: {
                        Text(Constant.location)
                            .font(.body)
                            .fontWeight(.medium)
                        Text(viewModel.location)
                            .font(.body)
                            .fontWeight(.light)
                    })
                    
                })
                .padding(.leading, Constant.padding)
                .padding(.trailing, Constant.padding)
                
                Spacer()
            })
            .edgesIgnoringSafeArea(.top)
        }
    }
}

#Preview {
    CharacterDetailsView(viewModel: CharacterDetailsViewModel(with: Character(
        id: 1,
        name: "Jack Raya",
        status: .dead,
        species: "Human",
        gender: .male,
        location: CharacterLocation(name: "Eartch"), 
        image: URL(string: "https://rickandmortyapi.com/api/character/avatar/362.jpeg")!
    ), actionCallback: nil))
}
