//
// MockURLSession.swift


import Foundation
@testable import Networking
class MockURLSession: URLSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    init(
        data: Data? = nil,
        statusCode: Int = 200,
        error: Error? = nil) {
            self.data = data
            self.response = HTTPURLResponse(url: URL(string: "https://mockurl.com")!,
                                            statusCode: statusCode,
                                            httpVersion: nil,
                                            headerFields: nil)
            self.error = error
        }
    
    func dataTask(
        with url: URL,
        completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            completionHandler(data, response, error)
            return URLSession.shared.dataTask(with: url)
        }
    
}
