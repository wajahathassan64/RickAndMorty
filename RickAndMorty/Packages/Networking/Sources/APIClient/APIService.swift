//
// APIClientNew.swift


import Foundation

public protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

public protocol APIServiceType {
    func request<T: Decodable>(
        endpoint: Endpoint,
        completion: @escaping (Result<T, NetworkError>) -> Void)
}


extension URLSession: URLSessionProtocol { }


open class APIService: APIServiceType {
    private let session: URLSessionProtocol
    
    public init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    public func request<T: Decodable>(endpoint: Endpoint, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = endpoint.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        
        let task = session.dataTask(with: url) { data, response, error in
            // Handle network error
            if let error = error {
                completion(.failure(.networkError(error)))
                return // Return here to prevent multiple calls
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.serverError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            // Handle decoding
            if T.self == Data.self {
                completion(.success(data as! T))
            } else {
                do {
                    let decoded = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
        task.resume()
    }
}
