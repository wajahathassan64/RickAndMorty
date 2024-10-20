//
// UITableViewCellExtensionTests.swift

import XCTest
import UIKit

@testable import Core

final class UITableViewCellExtensionTests: XCTestCase {
    
    class MockTableViewCell: UITableViewCell { }
    
    func testReuseIdentifier() {
        
        let reuseIdentifier = MockTableViewCell.reuseIdentifier
        
        XCTAssertEqual(reuseIdentifier, "MockTableViewCell")
    }
    
    func testDefaultReuseIdentifierForBaseClass() {
        
        let reuseIdentifier = UITableViewCell.reuseIdentifier
 
        XCTAssertEqual(reuseIdentifier, "UITableViewCell")
    }
}
