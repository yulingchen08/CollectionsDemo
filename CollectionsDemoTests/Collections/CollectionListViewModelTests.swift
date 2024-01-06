//
//  CollectionListViewModelTests.swift
//  CollectionsDemoTests
//
//  Created by 陳鈺翎 on 2024/1/7.
//

import RxSwift
import XCTest
@testable import CollectionsDemo

final class CollectionListViewModelTests: XCTestCase {
    
    private var repository: NftRepositoryMock!
    private var disposeBag: DisposeBag!
    private var sut: CollectionListViewModel!

    override func setUpWithError() throws {
        disposeBag = DisposeBag()
        repository = NftRepositoryMock()
        sut = CollectionListViewModel(nftRepository: repository)
    }

    override func tearDownWithError() throws {
        repository = nil
        sut = nil
    }

    func testInitializeDataFetch() {
        let presentCollectionCellExpectation = expectation(description: "presentCollectionCell is called")
        sut.outputs.presentCollectionCell = {
            presentCollectionCellExpectation.fulfill()
        }
        
        sut.inputs.initializeDataFetch()
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertEqual(sut.inputs.dataSource.galleries.count, 1)
        XCTAssertEqual(sut.inputs.dataSource.totalCount, 1)
        XCTAssertEqual(sut.inputs.dataSource.pageKey, "key")
        XCTAssertEqual(sut.inputs.dataSource.galleries[0].contractName, "A contract name")
        XCTAssertEqual(sut.inputs.dataSource.galleries[0].name, "A name")
    }
    
    func testFetchMoreCollectionsWithCountsLeft() {
        sut.dataSource = .mockWithRemainingCount
        let presentCollectionCellExpectation = expectation(description: "presentCollectionCell is called")
        sut.outputs.presentCollectionCell = {
            presentCollectionCellExpectation.fulfill()
        }
        
        sut.inputs.fetchMoreCollections()
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertEqual(sut.inputs.dataSource.galleries.count, 3)
        XCTAssertEqual(sut.inputs.dataSource.totalCount, 1)
        XCTAssertEqual(sut.inputs.dataSource.pageKey, "key")
        XCTAssertEqual(sut.inputs.dataSource.galleries[0].contractName, "contract1")
        XCTAssertEqual(sut.inputs.dataSource.galleries[0].name, "name1")
    }
    
    func testFetchMoreCollectionsWithMoreThan20CountsLeft() {
        sut.dataSource = .mockWithMoreRemainingCount
        let presentCollectionCellExpectation = expectation(description: "presentCollectionCell is called")
        sut.outputs.presentCollectionCell = {
            presentCollectionCellExpectation.fulfill()
        }
        
        sut.inputs.fetchMoreCollections()
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertEqual(sut.inputs.dataSource.galleries.count, 3)
        XCTAssertEqual(sut.inputs.dataSource.totalCount, 1)
        XCTAssertEqual(sut.inputs.dataSource.pageKey, "key")
        XCTAssertEqual(sut.inputs.dataSource.galleries[0].contractName, "contract one")
        XCTAssertEqual(sut.inputs.dataSource.galleries[0].name, "name one")
    }
    
    func testFetchMoreCollectionsWithoutCountsLeft() {
        sut.dataSource = .mockWithoutRemainingCount
        sut.inputs.fetchMoreCollections()

        Thread.sleep(forTimeInterval: 2.0)
        XCTAssertEqual(sut.inputs.dataSource.galleries.count, 2)
        XCTAssertEqual(sut.inputs.dataSource.totalCount, 2)
        XCTAssertEqual(sut.inputs.dataSource.pageKey, "key")
        XCTAssertEqual(sut.inputs.dataSource.galleries[0].contractName, "contract1")
        XCTAssertEqual(sut.inputs.dataSource.galleries[0].name, "name1")
    }
    
    func testUpdateCollectionFailed() {
        repository.setShouldReturnError(true)
        
        let expectation = XCTestExpectation(description: "Error is called")
        
        sut.outputs.presentCollectionCell = {
            XCTFail("presentCollectionCell should not be called on error")
        }
        
        sut.inputs.initializeDataFetch()
        
        _ = XCTWaiter.wait(for: [expectation], timeout: 2.0)
        XCTAssertEqual(sut.inputs.dataSource.galleries.count, 0)
        XCTAssertEqual(sut.inputs.dataSource.totalCount, 0)
        XCTAssertNil(sut.inputs.dataSource.pageKey)
    }

}
