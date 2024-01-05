//
//  CollectionDTO.swift
//  CollectionsDemo
//
//  Created by 陳鈺翎 on 2024/1/3.
//

import Foundation

struct NftApiResponse: Codable {
    let ownedNfts: [OwnedNft]
    let totalCount: Int
    let validAt: ValidAt
    let pageKey: String?
}

struct OwnedNft: Codable {
    let contract: Contract
    let tokenId: String?
    let tokenType: String?
    let name: String
    let description: String?
    let owners: String?
    let tokenUri: String
    let image: Image
    let collection: Collection?
    let timeLastUpdated: String
    let balance: String
}

struct Collection: Codable {
    let name: String?
    let slug: String?
    let externalUrl: String?
    let bannerImageUrl: String?
}

struct Contract: Codable {
    let address: String
    let name: String
    let symbol: String
    let totalSupply: String?
    let tokenType: String
    let contractDeployer: String
    let deployedBlockNumber: Int
    let openSeaMetadata: OpenSeaMetadata
    let isSpam: Bool?
}

struct Image: Codable {
    let cachedUrl: String?
    let thumbnailUrl: String?
    let pngUrl: String?
    let contentType: String?
    let size: Int?
    let originalUrl: String?
}

struct OpenSeaMetadata: Codable {
    let floorPrice: Int?
    let collectionName: String?
    let collectionSlug: String?
    let safelistRequestStatus: String?
    let imageUrl: String?
    let description: String?
}

struct ValidAt: Codable {
    let blockNumber: Int
    let blockHash: String
    let blockTimestamp: String
}
