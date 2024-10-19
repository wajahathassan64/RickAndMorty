//
// SessionAdapter.swift


import Foundation
import Alamofire

// Wrapper class to adapt Alamofire's Session to SessionType
final public class SessionAdapter: SessionType {
    private let session: Session
    public static let `default` = SessionAdapter()
    
    // Initialize the wrapper with a real Alamofire Session
    init(session: Session = Session.default) {
        self.session = session
    }
    
    public func request(_ convertible: URLRequestConvertible) -> DataRequestType {
        let dataRequest = session.request(convertible)
        return DataRequestWrapper(dataRequest: dataRequest)
    }
}

