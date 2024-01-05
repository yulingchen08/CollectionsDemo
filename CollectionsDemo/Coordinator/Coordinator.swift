//
//  Coordinator.swift
//  CollectionsDemo
//
//  Created by 陳鈺翎 on 2024/1/5.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigation: BaseNavigationController? { get set }
}

extension Coordinator {
    func start() {}
}

