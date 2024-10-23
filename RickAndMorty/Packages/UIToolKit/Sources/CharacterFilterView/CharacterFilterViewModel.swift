//
// CharacterFilterViewModel.swift


import Foundation

// MARK: - Filter ViewModel Protocol
protocol CharacterFilterViewModelType: ObservableObject {
    var isAliveEnabled: Bool { get }
    var isDeadEnabled: Bool { get }
    var isUnknownEnabled: Bool { get }
    var statusChangeCallback: ((String?) -> Void)? { get set }
    
    func selectedFilter(with status: String)
}

// MARK: - Filter ViewModel
public final class CharacterFilterViewModel: CharacterFilterViewModelType {
    // MARK: - Properties
    private var status: String?
    
    @Published var isAliveEnabled: Bool = false
    @Published var isDeadEnabled: Bool = false
    @Published var isUnknownEnabled: Bool = false
    
    public var statusChangeCallback: ((String?) -> Void)?
    
    // MARK: - Functions
    func selectedFilter(with status: String) {
        if self.status == status {
            self.status = nil
        } else {
            self.status = status
        }
        
        isAliveEnabled = self.status == "alive"
        isDeadEnabled = self.status == "dead"
        isUnknownEnabled = self.status == "unknown"
        
        statusChangeCallback?(self.status)
    }
}
