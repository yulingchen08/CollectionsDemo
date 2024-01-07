//
//  CollectionViewModel.swift
//  CollectionsDemo
//
//  Created by 陳鈺翎 on 2024/1/5.
//

import Foundation

struct CollectionViewModel {
    var galleries: [Gallery]
    var pageKey: String?
    var totalCount: Int
}

struct Gallery {
    var contractName: String
    var name: String
    var description: String?
    var imageUrl: String?
    var contentType: ContentType
}
