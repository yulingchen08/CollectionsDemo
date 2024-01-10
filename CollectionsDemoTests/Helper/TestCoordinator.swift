//
//  TestCoordinator.swift
//  CollectionsDemoTests
//
//  Created by 陳鈺翎 on 2024/1/7.
//

import Foundation
import UIKit
@testable import CollectionsDemo

class TestCoordinator: Coordinator {
    var navigation: BaseNavigationController

    init(navigation: BaseNavigationController) {
        self.navigation = navigation
    }

    func start() {
        let viewController = UIViewController()
        navigation.pushViewController(
            viewController,
            animated: true
        )
    }
}
