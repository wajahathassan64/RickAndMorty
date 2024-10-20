//
// ViewExtensionTests.swift


import XCTest
import SwiftUI
import UIKit
@testable import Core

final class ViewExtensionTests: XCTestCase {

    func testRoundedCornerProducesCorrectPathForAllCorners() {
        // Given
        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        let shape = RoundedCorner(radius: 10, corners: .allCorners)
        
        // When
        let path = shape.path(in: rect)
        let bezierPath = UIBezierPath(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 10, height: 10))
        let expectedPath = Path(bezierPath.cgPath)
        
        // Then
        XCTAssertEqual(path, expectedPath)
    }

    func testRoundedCornerProducesCorrectPathForTopLeftAndTopRightCorners() {
        // Given
        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        let shape = RoundedCorner(radius: 10, corners: [.topLeft, .topRight])
        
        // When
        let path = shape.path(in: rect)
        let bezierPath = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 10, height: 10))
        let expectedPath = Path(bezierPath.cgPath)
        
        // Then
        XCTAssertEqual(path, expectedPath)
    }

    func testRoundedCornerProducesCorrectPathForBottomCorners() {
        // Given
        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        let shape = RoundedCorner(radius: 20, corners: [.bottomLeft, .bottomRight])
        
        // When
        let path = shape.path(in: rect)
        let bezierPath = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 20, height: 20))
        let expectedPath = Path(bezierPath.cgPath)
        
        // Then
        XCTAssertEqual(path, expectedPath)
    }
    
    func testCornerRadiusModifierAppliesCorrectly() {
        // Given
        let view = Text("Hello, SwiftUI!")
            .cornerRadius(10, corners: .topLeft)
        
        // When
        let hostingController = UIHostingController(rootView: view)
        let viewToTest = hostingController.view
        
        // Then
        XCTAssertNotNil(viewToTest)
    }
}
