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
        sut.rootViewController.delegate?.didClickImage(gallery: Gallery(
            contractName: "",
            name: ""
        ))
        XCTAssertTrue(delegateSpy.didClickImageCalled)
    }
}

class DelegateSpy: CollectionListViewControllerDelegate {
    var didClickImageCalled = false
    
    func didClickImage(gallery: Gallery) {
        didClickImageCalled = true
    }
}
