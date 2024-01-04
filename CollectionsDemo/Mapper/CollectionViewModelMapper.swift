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
            let contract = $0.contract
            let contractName = contract.name
            let name = contract.openSeaMetadata.collectionName
            let description = contract.openSeaMetadata.description
            let imageUrl = contract.openSeaMetadata.imageUrl
            
            return Gallery(
                contractName: contractName,
                name: name,
                description: description,
                imageUrl: imageUrl
            )
        }
        return CollectionViewModel(galleries: galleries)
    }
}
