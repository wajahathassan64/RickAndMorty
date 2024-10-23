//
// CharacterTableHeaderViewModel.swift


import Foundation
import Core

protocol CharacterTableHeaderViewModelType: ReusableCellViewModelType {
    var filterViewModel: CharacterFilterViewModel { get }
}

public final class CharacterTableHeaderViewModel: CharacterTableHeaderViewModelType {
    public var filterViewModel: CharacterFilterViewModel =  CharacterFilterViewModel()
    public var reuseIdentifier: String = CharacterTableHeaderView.reuseIdentifier
    
    public init() { }
}
