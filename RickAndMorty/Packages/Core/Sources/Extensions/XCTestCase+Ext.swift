//
// XCTestCase+Ext.swift


import Foundation
import XCTest

extension XCTestCase {
    func wait(for time: Double) {
        let exp = expectation(description: "Wait for main thread")
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            exp.fulfill()
        }
        wait(for: [exp], timeout: time + 1.0)
    }
}
