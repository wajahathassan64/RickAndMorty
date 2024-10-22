//
// CharacterListViewModelTests.swift


import XCTest
@testable import Characters

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
        wait(for: [reloadExp], timeout: 1.0)
        XCTAssertTrue(mockService.didFetchCharacters)
        XCTAssertEqual(sut.numberOfRows(in: 1), character.count)
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
        XCTAssertTrue(mockService.didFetchCharacters)
        XCTAssertEqual(sut.numberOfRows(in: 0), 0)
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
        XCTAssertFalse(mockService.didFetchCharacters)
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            displayExpectation.fulfill()
        }
        
        // then
        XCTAssertTrue(mockService.didFetchCharacters)
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
    
    func testFilterSelection_thenShouldLoadDataFromStart() {
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
//        (sut.headerViewModel(for: .zero) as! CharacterListHeaderViewModel).filterViewModel.selectedFilter(with: .alive)
        
        // then
        wait(for: [reloadExp2], timeout: 1.0)
        XCTAssertEqual(sut.numberOfRows(in: .zero), 2)
    }
    
}
