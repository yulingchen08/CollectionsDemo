//
//  CollectionListCoordinatorTests.swift
//  CollectionsDemoTests
//
//  Created by 陳鈺翎 on 2024/1/6.
//

import XCTest
@testable import CollectionsDemo

final class CollectionListCoordinatorTests: XCTestCase {
    private var navigation: BaseNavigationController!
    private var sut: CollectionListCoordinator!
    
    override func setUpWithError() throws {
        navigation = BaseNavigationController()
        sut = CollectionListCoordinator(navigation: navigation)
    }
    
    override func tearDownWithError() throws {
        navigation = nil
        sut = nil
    }
    
    func testStart() throws {
        var didClickImageCalled = false
        let delegateSpy = DelegateSpy()
        sut.start()
        
        XCTAssertEqual(navigation.viewControllers.count, 1)
        XCTAssertTrue(navigation.viewControllers.first is CollectionListViewController)
        XCTAssertNotNil(sut.rootViewController.delegate)
        
        sut.rootViewController.delegate = delegateSpy
        sut.rootViewController.delegate?.didClickCell(gallery: Gallery(
            tokenId: "",
            contractName: "",
            address: "",
            name: "",
            contentType: .png
        ))
        XCTAssertTrue(delegateSpy.didClickImageCalled)
    }
    
    func testDidClickCell() {
        sut.start()
        let testGallery: Gallery = .mock
        
        sut.didClickCell(gallery: testGallery)
        
        XCTAssertNotNil(sut.collectionDetailCoordinator)
    }
}

class DelegateSpy: CollectionListViewControllerDelegate {
    var didClickImageCalled = false
    func didClickCell(gallery: CollectionsDemo.Gallery) {
        didClickImageCalled = true
    }
}
