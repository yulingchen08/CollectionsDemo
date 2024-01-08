//
//  AppCoordinatorTests.swift
//  CollectionsDemoTests
//
//  Created by 陳鈺翎 on 2024/1/6.
//

import XCTest
@testable import CollectionsDemo

final class AppCoordinatorTests: XCTestCase {

    private var window: UIWindow!
    private var navigation: BaseNavigationController!
    private var sut: AppCoordinator!

    override func setUpWithError() throws {
        window = UIWindow()
        navigation = BaseNavigationController()
        sut = AppCoordinator(
            window: window,
            navigation: navigation
        )
    }

    override func tearDownWithError() throws {
        window = nil
        navigation = nil
        sut = nil
    }

    func testStart() {
        sut.start()

        XCTAssertNotNil(window.rootViewController)
        XCTAssertTrue(window.rootViewController is BaseNavigationController)
        XCTAssertTrue(!navigation.viewControllers.isEmpty)
        XCTAssertTrue(navigation.isNavigationBarHidden)
    }
}
