//
//  MockNavigationController.swift
//  CollectionsDemoTests
//
//  Created by 陳鈺翎 on 2024/1/7.
//

import UIKit
@testable import CollectionsDemo

class MockNavigationController: BaseNavigationController {
    var pushViewControllerCalled = false

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewControllerCalled = true
        super.pushViewController(viewController, animated: animated)
    }
}
