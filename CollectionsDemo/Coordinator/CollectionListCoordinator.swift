//
//  CollectionListCoordinator.swift
//  CollectionsDemo
//
//  Created by 陳鈺翎 on 2024/1/5.
//

import UIKit

class CollectionListCoordinator: Coordinator {
    var navigation: BaseNavigationController
    private lazy var collectionDetailCoordinator = CollectionDetailCoordinator(navigation: navigation)
    private let rootViewController: CollectionListViewController

    init(navigation: BaseNavigationController) {
        self.navigation = navigation
        let repository: NftRepositoryProtocol = DependencyContainer.shared.getService()
        let viewModel = CollectionListViewModel(nftRepository: repository)
        self.rootViewController = CollectionListViewController(viewModel: viewModel)
    }

    func start() {
        rootViewController.delegate = self
        navigation.pushViewController(
            rootViewController,
            animated: false
        )
    }
}

extension CollectionListCoordinator: CollectionListViewControllerDelegate {
    func didClickCell(gallery: Gallery) {
        showCollectionDetailViewController(gallery: gallery)
    }
}

private extension CollectionListCoordinator {
    func showCollectionDetailViewController(gallery: Gallery) {
        collectionDetailCoordinator.start(gallery: gallery)
    }
}
