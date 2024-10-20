//
// UITableViewHeaderFooterViewExtensionTests.swift


import XCTest
import UIKit
@testable import Core

final class UITableViewHeaderFooterViewExtensionTests: XCTestCase {
    func testReuseId() {
        
         let reuseIdentifier = MockTableViewHeaderFooterView.reuseIdentifier
        
         XCTAssertEqual(reuseIdentifier, "MockTableViewHeaderFooterView")
     }
     
     func testDefaultReuseIdForBaseClass() {
         
         let reuseIdentifier = UITableViewHeaderFooterView.reuseIdentifier
         
         XCTAssertEqual(reuseIdentifier, "UITableViewHeaderFooterView")
     }
}

class MockTableViewHeaderFooterView: UITableViewHeaderFooterView { }
