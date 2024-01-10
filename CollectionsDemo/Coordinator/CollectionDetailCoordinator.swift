//
//  CollectionDetailCoordinator.swift
//  CollectionsDemo
//
//  Created by 陳鈺翎 on 2024/1/8.
//

import UIKit

class CollectionDetailCoordinator:  Coordinator {
    var navigation: BaseNavigationController
    var rootViewController: CollectionDetailViewController?
    init(navigation: BaseNavigationController) {
        self.navigation = navigation
    }

    func start(gallery: Gallery) {
        let viewModel = CollectionDetailViewModel(gallery: gallery)
        rootViewController = CollectionDetailViewController(viewModel: viewModel)
        rootViewController?.delegate = self
        navigation.pushViewController(
            rootViewController!,
            animated: true
        )
    }
}

extension CollectionDetailCoordinator: CollectionDetailViewControllerDelegate {
    func didBackActionClick() {
        navigation.popViewController(animated: true)
        rootViewController = nil
    }
}
