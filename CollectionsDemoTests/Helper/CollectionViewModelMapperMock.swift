//
//  CollectionViewModelMapperMock.swift
//  CollectionsDemoTests
//
//  Created by 陳鈺翎 on 2024/1/5.
//

import Foundation
@testable import CollectionsDemo

final class CollectionViewModelMapperMock: CollectionViewModelMapping {
    func map(response: CollectionsDemo.NftApiResponse) -> CollectionViewModel {
        let gallery = Gallery(
            tokenId: "tokenId",
            contractName: "contractName",
            address: "address",
            name: "name",
            description: "description",
            contentType: .png
        )
        return CollectionViewModel(
            galleries: [gallery],
            totalCount: 1
        )
    }
}
