//
//  CollectionListCoordinator.swift
//  CollectionsDemo
//
//  Created by 陳鈺翎 on 2024/1/5.
//

import UIKit

class CollectionListCoordinator: Coordinator {
    var navigation: BaseNavigationController?
    let rootViewController = ViewController()
    
    init(navigation: BaseNavigationController? = nil) {
        self.navigation = navigation
    }
    
    func start() {
        guard let navigation = navigation else { return }
        navigation.pushViewController(rootViewController, animated: false)
    }
    
}
