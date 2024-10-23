//
// Filename.swift

import XCTest
import UIKit
@testable import Core

class MockDependencyContainer {}

class TestFlowController: FlowController<MockDependencyContainer> {
    override func startFlow() { }
    
    override func deallocate() { }
}

final class FlowControllerTests: XCTestCase {
    
    var sut: TestFlowController!
    var mockNavigationController: MockNavigationController!

    override func setUp() {
        super.setUp()
        // given - setup mocks
        mockNavigationController = MockNavigationController()
        sut = TestFlowController(rootNavigationController: mockNavigationController, dependency: MockDependencyContainer())
    }

    override func tearDown() {
        sut = nil
        mockNavigationController = nil
        super.tearDown()
    }

    func testStartFlow_ShouldNotCrash() {
        sut.startFlow()
    }
    
    func testDeallocate_ShouldNotCrash() {
        sut.deallocate()
    }

    func testDismissViewController() {
        // given
        let presentedViewController = UIViewController()
        mockNavigationController.present(presentedViewController, animated: false)

        // when
        sut.dismissViewController(animated: false)

        // then
        XCTAssertNil(mockNavigationController.presentedViewController)
    }

    func testClearNavigationStack() {
        // given
        let viewControllerToPush = UIViewController()
        sut.pushViewController(viewControllerToPush, animated: false)

        // when
        sut.clearNavigationStack()

        // then
        XCTAssertTrue(mockNavigationController.viewControllers.isEmpty)
        XCTAssertNil(sut.rootNavigationController)
    }
}
