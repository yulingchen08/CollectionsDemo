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
        let repository = NftRepository(viewModelMapper: CollectionViewModelMapper())
        let viewModel = CollectionListViewModel(nftRepository: repository)
        self.rootViewController = CollectionListViewController(viewModel: viewModel)
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

extension CollectionListCoordinator: CollectionListViewControllerDelegate {
    func didClickImage(gallery: Gallery) {
        // TODO:
    }
}
