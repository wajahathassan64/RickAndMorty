//
// RMAService.swift


import Foundation
import Networking

public typealias Success<T: Decodable> = (T) -> Void
public typealias Failure = (Error) -> Void

protocol AppServiceType {
    func getCharacters(for page: Int, status: RMCharacterStatus, onSuccess: @escaping Success<RMGetAllCharactersResponse>, onFailure: @escaping Failure )
}


final class RMService: AppServiceType {
    
    let apiService: APIServiceType
    
    var baseUrl: URL = {
        if let urlString = Bundle.main.object(forInfoDictionaryKey: "BaseUrl") as? String,
           let url = URL(string: urlString) {
            return url
        } else {
            fatalError("URL not found.")
        }
    }()
    
    init(apiService: APIServiceType) {
        self.apiService = apiService
    }
    
    func getCharacters(for page: Int, status: RMCharacterStatus, onSuccess: @escaping Success<RMGetAllCharactersResponse>, onFailure: @escaping Failure) {
        
        let endpoint = Endpoint(baseURL: baseUrl, path: "/products", method: .PUT)
        
        apiService.request(endpoint: endpoint) { (result: Result<RMGetAllCharactersResponse, NetworkError>) in
            switch result {
            case .success(let result):
                print("response result = ", result)
            case .failure(let error):
                print("Error fetching products:", error.localizedDescription)
            }
        }
    }
    
}
