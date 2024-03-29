//
//  CoordinatorTests.swift
//  CollectionsDemoTests
//
//  Created by 陳鈺翎 on 2024/1/7.
//

import XCTest
@testable import CollectionsDemo

final class CoordinatorTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testStart() {
        let mockNavigationController = MockNavigationController()
        let coordinator = TestCoordinator(navigation: mockNavigationController)

        coordinator.start()

        XCTAssertTrue(mockNavigationController.pushViewControllerCalled)
    }
}
