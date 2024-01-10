//
//  AppCoordinator.swift
//  CollectionsDemo
//
//  Created by 陳鈺翎 on 2024/1/5.
//

import UIKit

class AppCoordinator: Coordinator {
    private weak var window: UIWindow?
    private var collectionListCoordinator: CollectionListCoordinator?
    var navigation: BaseNavigationController

    init(window: UIWindow?, navigation: BaseNavigationController) {
        self.window = window
        self.navigation = navigation
    }

    func start() {
        guard let window = window else { return }
        navigation.setNavigationBarHidden(true, animated: false)
        window.rootViewController = navigation
        collectionListCoordinator = CollectionListCoordinator(navigation: navigation)
        collectionListCoordinator?.start()

        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}
