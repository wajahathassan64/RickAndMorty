//
// CharacterListViewModel.swift


import Foundation
import Core
import UIToolKit

protocol CharacterListViewModelType {
    var numberOfSections: Int { get }
    var reloadCallback: (() -> Void)? { get set }
    
    func numberOfRows(in section: Int) -> Int
    func cellViewModelForRow(at indexPath: IndexPath) -> ReusableCellViewModelType
    func willDisplayCell(for indexPath: IndexPath)
    func onViewAppear()
}

typealias CharacterListActionCallback = () -> Void

final class CharacterListViewModel: CharacterListViewModelType {
    // MARK: - Properties
    var numberOfSections: Int
    var reloadCallback: (() -> Void)?
    
    private let characterService: AppServiceType
    private var shouldFetchMore = true
    private var currentPage = 0
    private var characters = [Character]()
    private var cellViewModels: [ReusableCellViewModelType] = []
    private let actionCallback: CharacterListActionCallback?
    
    // MARK: - Initializer
    init(service: AppServiceType, actionCallback: CharacterListActionCallback?) {
        self.characterService = service
        self.actionCallback = actionCallback
        self.numberOfSections = 1
    }
}

extension CharacterListViewModel {
    func onViewAppear() {
        loadFromStart()
    }
    
    func numberOfRows(in section: Int) -> Int {
        cellViewModels.count
    }
    
    func cellViewModelForRow(at indexPath: IndexPath) -> ReusableCellViewModelType {
        cellViewModels[indexPath.row]
    }
    
    //    func headerViewModel(for section: Int) -> any ReusableCellViewModelType {
    //        headerViewModel
    //    }
    
    func selectedRow(at indexPath: IndexPath) {
        //        actionCallback?(.openDetails(characters[indexPath.row]))
    }
    
    func willDisplayCell(for indexPath: IndexPath) {
        guard indexPath.row == cellViewModels.count - 1 else { return }
        Task {
            await fetchCharacters()
        }
    }
}

private extension CharacterListViewModel {
    func loadFromStart() {
        cellViewModels.removeAll()
        characters.removeAll()
        //        cellViewModels.append(loaderViewModel)
        reloadCallback?()
        currentPage = 0
        shouldFetchMore = true
        Task {
            await fetchCharacters()
        }
    }
}

private extension CharacterListViewModel {
    func fetchCharacters() async {
        
        guard shouldFetchMore else { return }
        
        do {
            let response = try await characterService.getCharacters(for: currentPage + 1, status: nil)
            handleSuccessResponse(response)
        } catch {
            handleError()
        }
    }
    
    func handleSuccessResponse(_ response: CharactersResponse) {
        shouldFetchMore = response.info.next != nil
        currentPage += 1
        characters.append(contentsOf: response.results)
        
        // Ensure we're on the main thread before updating UI-related code
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            // Perform UI updates on the main thread
            let loader = self.cellViewModels.popLast() ?? CharacterCellViewModel(charImageUrl: nil, charName: "", charSpecies: "", charStatusString: "")
            
            // Append new character cell view models
            self.cellViewModels.append(
                contentsOf:
                    response
                    .results
                    .map {
                        CharacterCellViewModel(
                            charImageUrl: $0.image,
                            charName: $0.name,
                            charSpecies: $0.species, 
                            charStatusString: $0.status.rawValue)
                    })
            
            if self.shouldFetchMore {
                self.cellViewModels.append(loader)
            }
            
            self.reloadCallback?()
        }
    }
    
    func handleError() {
        shouldFetchMore = false
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            if !self.cellViewModels.isEmpty {
                self.cellViewModels.removeLast()
            }
            
            self.reloadCallback?()
        }
    }
}
