//
//  CollectionDetailCoordinator.swift
//  CollectionsDemo
//
//  Created by 陳鈺翎 on 2024/1/8.
//

import UIKit

class CollectionDetailCoordinator:  Coordinator {
    var navigation: BaseNavigationController?
    var rootViewController: CollectionDetailViewController?
    init(navigation: BaseNavigationController? = nil) {
        self.navigation = navigation
    }
    
    func start(gallery: Gallery) {
        guard let navigation = navigation else { return }
        let viewModel = CollectionDetailViewModel(gallery: gallery)
        rootViewController = CollectionDetailViewController(viewModel: viewModel)
        navigation.pushViewController(
            rootViewController!,
            animated: true
        )
    }
}
