//
// CharacterFilterViewModelTests.swift


import XCTest
@testable import UIToolKit

final class CharacterFilterViewModelTests: XCTestCase {

    var sut: CharacterFilterViewModel!

    override func setUp() {
        super.setUp()
        sut = CharacterFilterViewModel()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Tests

    func testInitialState() {
        // The initial state should have all filters disabled
        XCTAssertFalse(sut.isAliveEnabled)
        XCTAssertFalse(sut.isDeadEnabled)
        XCTAssertFalse(sut.isUnknownEnabled)
        XCTAssertNil(sut.statusChangeCallback)
    }

    func testSelectingAliveFilter() {
        // when
        sut.selectedFilter(with: "alive")

        // then
        XCTAssertTrue(sut.isAliveEnabled)
        XCTAssertFalse(sut.isDeadEnabled)
        XCTAssertFalse(sut.isUnknownEnabled)
    }

    func testSelectingDeadFilter() {
       // when
        sut.selectedFilter(with: "dead")

        // then
        XCTAssertFalse(sut.isAliveEnabled)
        XCTAssertTrue(sut.isDeadEnabled)
        XCTAssertFalse(sut.isUnknownEnabled)
    }

    func testSelectingUnknownFilter() {
       // when
        sut.selectedFilter(with: "unknown")

        // then
        XCTAssertFalse(sut.isAliveEnabled)
        XCTAssertFalse(sut.isDeadEnabled)
        XCTAssertTrue(sut.isUnknownEnabled)
    }

    func testTogglingFilterOff() {
        // given
        sut.selectedFilter(with: "alive")
        XCTAssertTrue(sut.isAliveEnabled) // Precondition check

        // when
        sut.selectedFilter(with: "alive")

        // then
        XCTAssertFalse(sut.isAliveEnabled)
        XCTAssertFalse(sut.isDeadEnabled)
        XCTAssertFalse(sut.isUnknownEnabled)
    }

    func testStatusChangeCallback() {
        // given
        let expectation = XCTestExpectation(description: "Status change callback should be called")
       
        sut.statusChangeCallback = { status in
            XCTAssertEqual(status, "alive")
            expectation.fulfill()
        }

        // when
        sut.selectedFilter(with: "alive")

        // then
        wait(for: [expectation], timeout: 1.0)
    }

    func testStatusChangeCallbackReset() {
        // given
        sut.selectedFilter(with: "alive")

        let expectation = XCTestExpectation(description: "Status change callback should be called with nil")

        sut.statusChangeCallback = { status in
            XCTAssertNil(status)
            expectation.fulfill()
        }
        
        // when
        sut.selectedFilter(with: "alive")

        // then
        wait(for: [expectation], timeout: 1.0)
    }
}
