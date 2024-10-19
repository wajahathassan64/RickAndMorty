//
// Endpoint.swift


import Foundation

public enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}

public struct Endpoint {
    let baseURL: URL
    let path: String
    let method: HTTPMethod
    let headers: [String: String]?
    let queryParams: [String: String]?
    
    var url: URL? {
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        components?.path += path
        
        components?.queryItems = queryParams?.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        return components?.url
    }
    
    public init(baseURL: URL, path: String, method: HTTPMethod, headers: [String: String]? = nil, queryParams: [String: String]? = nil) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.headers = headers
        self.queryParams = queryParams
    }
}

