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
            let contractName = $0.contract.name
            let name = $0.name
            let description = $0.description
            let imageUrl = $0.image.originalUrl
            
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
