//
//  CollectionListCoordinator.swift
//  CollectionsDemo
//
//  Created by 陳鈺翎 on 2024/1/5.
//

import UIKit

class CollectionListCoordinator: Coordinator {
    var navigation: BaseNavigationController?
    let rootViewController: CollectionListViewController
    
    init(navigation: BaseNavigationController? = nil) {
        self.navigation = navigation
        self.rootViewController = CollectionListViewController(viewModel: CollectionListViewModel())
    }
    
    func start() {
        guard let navigation = navigation else { return }
        rootViewController.delegate = self
        navigation.pushViewController(
            rootViewController,
            animated: false
        )
    }
}

extension CollectionListCoordinator {
    private func view() -> CollectionListViewController {
        let viewModel = CollectionListViewModel()
        return CollectionListViewController(viewModel: viewModel)
    }
}

extension CollectionListCoordinator: CollectionListViewControllerDelegate {
    func didClickImage(gallery: Gallery) {
        // TODO:
    }
}
