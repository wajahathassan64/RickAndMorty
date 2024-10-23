//
// CharacterListViewModelTests.swift


import XCTest
@testable import Characters
@testable import UIToolKit
@testable import Core

final class CharacterListViewModelTests: XCTestCase {
    
    // MARK: - Properties
    var sut: CharacterListViewModel!
    var mockService: MockCharacterService!
    
    private struct Constants {
        static let zeroRow = IndexPath(row: 0, section: 0)
        static let oneRow = IndexPath(row: 0, section: 0)
    }
    
    override func setUp() {
        super.setUp()
        mockService = MockCharacterService()
        sut = CharacterListViewModel(service: mockService, actionCallback: nil)
    }
    
    // MARK: - Tear down
    override func tearDown() {
        sut = nil
        mockService = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    func testNoOfSectionShouldBeOne() {
        XCTAssertEqual(sut.numberOfSections, 1)
    }
    
    func testNumberOfRowsWhenDataIsNotLoadedReturnsZero() {
        XCTAssertEqual(sut.numberOfRows(in: 0), 0)
    }
    
    func testLoadFromStartShouldPopulateCharactersWhenServiceReturnsData() {
        // given
        let character = MockCharacter.createMockCharacterList(count: 1)
        mockService.mockCharacters = character
        let reloadExp = XCTestExpectation(description: "Reload callback should be triggered")
        sut.reloadCallback = { reloadExp.fulfill() }
        
        // when
        sut.onViewAppear()
        
        // then
        wait(for: 0.1)
        XCTAssertTrue(mockService.didFetchCharacters)
        XCTAssertEqual(sut.numberOfRows(in: 0), character.count + 1) // Loader view also included.
        wait(for: [reloadExp], timeout: 1.0)
    }
    
    func testRowCountWhenNoDataLoadedShouldBeZero() {
        // given
        mockService.mockCharacters = nil
        let expectation = XCTestExpectation(description: "Callback for reloading should be triggered")
        sut.reloadCallback = { expectation.fulfill() }
        
        // when
        sut.onViewAppear()
        
        // then
        wait(for: [expectation], timeout: 1.0)
        wait(for: 1.0)
        XCTAssertTrue(mockService.didFetchCharacters)
        XCTAssertEqual(sut.numberOfRows(in: 0), 0)
    }
    
    func testSelectedRowShouldInvokeActionCallback() {
        // given
        let character = MockCharacter.createMockCharacter()
        mockService.mockCharacters = [character]
        let actionExp = XCTestExpectation(description: "Action callback should be triggered")
        let reloadExp = XCTestExpectation(description: "Reload callback should be triggered")
        sut = CharacterListViewModel(service: mockService, actionCallback: { action in
            actionExp.fulfill()
        })
        sut.reloadCallback = { reloadExp.fulfill() }
        sut.onViewAppear()
        wait(for: 0.1)
        wait(for: [reloadExp], timeout: 1.0)
        
        // when
        sut.selectedRow(at: IndexPath(row: 0, section: 0))
        
        // then
        wait(for: [actionExp], timeout: 1.0)
    }
    
    func testHeaderViewModel() {
        let headerViewModel = sut.headerViewModel(for: 0)
        XCTAssertTrue(headerViewModel is CharacterTableHeaderViewModel)
    }
    
    func testCellWillAppearWhenNotLastRowShouldNotTriggerFetch() {
        // given
        let characterList = [MockCharacter.createMockCharacter()]
        mockService.mockCharacters = characterList
        mockService.didFetchCharacters = false
        
        // when
        let displayExpectation = XCTestExpectation(description: "Cell display expectation")
        sut.willDisplayCell(for: Constants.zeroRow)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            displayExpectation.fulfill()
        }

        // then
        wait(for: [displayExpectation], timeout: 1.0)
       
    }
    
    func testWillDisplayCell_whenRowIsLastAndMoreDataCanBeLoaded_thenShouldCallGetCharactersOnService() {
        // given
        let characters = [MockCharacter.createMockCharacter()]
        mockService.mockCharacters = characters
        sut.onViewAppear()
        mockService.didFetchCharacters = false
        
        // when
        let displayExpectation = XCTestExpectation(description: "Cell display expectation")
        sut.willDisplayCell(for: Constants.oneRow)
        
        // then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {[weak self] in
            guard let self = self else { return }
            XCTAssertTrue(mockService.didFetchCharacters)
            displayExpectation.fulfill()
        }
        wait(for: [displayExpectation], timeout: 1.0)
    }
    
    func testWillDisplayCellWhenRowIsLastAndMoreDataCanNotBeLoadedThenShouldNotCallGetCharactersOnService() {
        // given
        mockService.mockCharacters = [MockCharacter.createMockCharacter()]
        mockService.mockInfo = .stub(next: nil)
        mockService.didFetchCharacters = false
        
        // when
        let displayExpectation = XCTestExpectation(description: "Cell display expectation")
        sut.willDisplayCell(for: Constants.zeroRow)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            displayExpectation.fulfill()
        }
        
        // then
        XCTAssertFalse(mockService.didFetchCharacters)
    }
    
    func testFilterSelectionThenShouldLoadDataFromStart() {
        // given
        mockService.mockCharacters = MockCharacter.createMockCharacterList(count: 2)
        let reloadExp = XCTestExpectation(description: "Reload callback should be triggered")
        sut.reloadCallback = { reloadExp.fulfill() }
        sut.onViewAppear()
        wait(for: [reloadExp], timeout: 1.0)
        
        mockService.mockCharacters = [MockCharacter.createMockCharacter()]
        let reloadExp2 = XCTestExpectation(description: "Reload callback should be triggered")
        sut.reloadCallback = { reloadExp2.fulfill() }
        
        // when
        (sut.headerViewModel(for: .zero) as! CharacterTableHeaderViewModel).filterViewModel.selectedFilter(with: "Alive")
        
        // then
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {[weak self] in
            guard let self = self else { return }
            XCTAssertEqual(sut.numberOfRows(in: .zero), 2)
        }
        wait(for: [reloadExp2], timeout: 1.0)
    }
    
}
