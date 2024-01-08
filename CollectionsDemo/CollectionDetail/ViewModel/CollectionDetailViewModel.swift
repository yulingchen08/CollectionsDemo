//
//  CollectionDetailViewModel.swift
//  CollectionsDemo
//
//  Created by 陳鈺翎 on 2024/1/8.
//

import Foundation

protocol CollectionDetailViewModelInputsType {
    func getOpenseaLink() -> URL?
}

protocol CollectionDetailViewModelType {
    var inputs: CollectionDetailViewModelInputsType { get }
}

class CollectionDetailViewModel: CollectionDetailViewModelInputsType, CollectionDetailViewModelType {
    
    private enum Constants {
        static let openSeaUrl = "https://testnets.opensea.io/assets/goerli/"
    }
    
    var inputs: CollectionDetailViewModelInputsType { return self }
    
    //MARK: - Outputs:
    var didUpdateUI: ((Gallery) -> Void) = {_ in }

    var gallery: Gallery
    
    init(gallery: Gallery) {
        self.gallery = gallery
    }
    
    func getOpenseaLink() -> URL? {
        let openSeaUrl = Constants.openSeaUrl + "\(gallery.address)/\(gallery.tokenId)"
        return URL(string: openSeaUrl)
    }
}
