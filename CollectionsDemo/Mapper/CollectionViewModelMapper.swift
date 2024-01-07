//
//  CollectionMapper.swift
//  CollectionsDemo
//
//  Created by 陳鈺翎 on 2024/1/5.
//

import Foundation

protocol CollectionViewModelMapping {
    func map(response: NftApiResponse) -> CollectionViewModel
}

class CollectionViewModelMapper: CollectionViewModelMapping {
    func map(response: NftApiResponse) -> CollectionViewModel {
        let galleries = response.ownedNfts.map {
            Gallery(
                contractName: $0.contract.name,
                name: $0.name,
                description: $0.description,
                imageUrl: $0.image.originalUrl,
                contentType: $0.image.contentType
            )
        }
        return CollectionViewModel(
            galleries: galleries,
            pageKey: response.pageKey,
            totalCount: response.totalCount
        )
    }
}
