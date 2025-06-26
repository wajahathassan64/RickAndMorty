//
// UIViewExtensionTests.swift


import UIKit
import SwiftUI
import XCTest
@testable import Core

final class UIViewExtensionTests: XCTestCase {
    
    // MARK: - Properties
    var sut: UIView!
    
    private struct Constants {
        static let subviewWithCorrectFrameAndInsets = "Subview should have correct frame with insets applied"
        static let subviewWithoutInsets = "Subview should match the boundds of the parent view with no insets applied"
        static let hostedSwiftUIViewSubview = "Subview should exist after hosting a SwiftUI view"
        static let oneSubviewAfterHostingSwiftUIView = "There should be exactly one subview after hosting a SwiftUI view"
        static let swiftUIViewReplacingOldSubview = "The old subview should be removed and replaced by the new SwiftUI view"
        static let removePreviousSubview = "The previous subview should be removed."
    }
    
    
    // MARK: - Setup
    override func setUp() {
        super.setUp()
        sut = UIView(frame: CGRect(x: .zero, y: .zero, width: 200, height: 200))
    }
    
    // MARK: - Tear down
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testEmbedViewWithInsets() {
        // given
        let subview = UIView()
        let inset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        // when
        sut.embedView(subview, insets: inset)
        sut.layoutIfNeeded()
        
        // then
        XCTAssertEqual(subview.frame, CGRect(x: 10, y: 10, width: 180, height: 180), Constants.subviewWithCorrectFrameAndInsets)
        
    }
    
    func testEmbedViewWithoutInsets() {
        // given
        let subview = UIView()
        
        // when
        sut.embedView(subview)
        sut.layoutIfNeeded()
        
        // then
        XCTAssertEqual(subview.frame, sut.bounds, Constants.subviewWithoutInsets)
    }
    
    func testHostSwiftUIView() {
        // given
        let swiftUIView = Text("Hello swiftUI")
        let subview: UIView?
        
        // when
        sut.host(swiftUIView)
        sut.layoutIfNeeded()
        subview = sut.subviews.first
        
        // then
        XCTAssertNotNil(subview, Constants.hostedSwiftUIViewSubview)
        XCTAssertEqual(sut.subviews.count, 1, Constants.oneSubviewAfterHostingSwiftUIView)
        
    }
    
    func testHostSwiftUIViewReplacesPreviousSubviews() {
        // given
        let previousSubview = UIView()
        sut.addSubview(previousSubview)
        let swiftUIView = Text("Hello, SwiftUI")
        
        // when
        sut.host(swiftUIView)
        sut.layoutIfNeeded()
        
        // then
        XCTAssertEqual(sut.subviews.count, 1, Constants.swiftUIViewReplacingOldSubview)
        XCTAssertFalse(sut.subviews.contains(previousSubview), Constants.removePreviousSubview)
    }
    
}
