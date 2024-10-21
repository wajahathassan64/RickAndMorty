//
// InstantiableTypeTests.swift

import XCTest
import UIKit
@testable import Core

class InstantiableTypeTests: XCTestCase {
    
    var storyboard: UIStoryboard!
    
    override func setUp() {
        super.setUp()
        storyboard = UIStoryboard(name: "MockViewController", bundle: .module)
    }
    
    override func tearDown() {
        storyboard = nil
        super.tearDown()
    }
    
    func testInstantiateFromStoryboard() {
        
        let viewController: MockViewController = MockViewController.instantiateFromStoryboard(with: "MockViewController", in: .module)
        
        XCTAssertNotNil(viewController)
    }
    
}

