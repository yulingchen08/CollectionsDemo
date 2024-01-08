//
//  CollectionsUITests.swift
//  CollectionsDemoUITests
//
//  Created by 陳鈺翎 on 2024/1/8.
//

import XCTest

final class CollectionsUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testCollectionViewTapOpensDetail() throws {
        let firstCell = app.collectionViews.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.waitForExistence(timeout: 15))
        XCTAssertTrue(app.collectionViews[Accessibility.listCollection].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts[Accessibility.balanceButton].waitForExistence(timeout: 5))
        XCTAssertTrue(app.images[Accessibility.galleryImageView].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts[Accessibility.galleryNameLabel].waitForExistence(timeout: 5))

        firstCell.tap()

        XCTAssertTrue(app.images[Accessibility.detailImageView].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts[Accessibility.detailNameLabel].waitForExistence(timeout: 5))
        XCTAssertTrue(app.textViews[Accessibility.detailDescriptionLabel].waitForExistence(timeout: 5))
        XCTAssertTrue(app.buttons[Accessibility.detailOpenseaButton].waitForExistence(timeout: 5))
    }
}
