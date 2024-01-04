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
    let pageKey: String
}

struct OwnedNft: Codable {
    let contract: Contract
    let tokenId, tokenType, name, description: String?
    let tokenUri: String
    let image: Image
    let raw: Raw
    let collection: Collection
    let owners: String?
    let timeLastUpdated: String
    let balance: String
}

struct Collection: Codable {
    let name, slug, externalUrl: String?
    let bannerImageUrl: String?
}

struct Contract: Codable {
    let address, name, symbol: String
    let totalSupply: String?
    let tokenType, contractDeployer: String
    let deployedBlockNumber: Int
    let openSeaMetadata: OpenSeaMetadata
    let isSpam: Bool
    let spamClassifications: [String]
}

struct Image: Codable {
    let cachedUrl, thumbnailUrl, pngUrl, contentType: String?
    let size, originalUrl: String?
}

struct OpenSeaMetadata: Codable {
    let floorPrice: Int
    let collectionName, collectionSlug, safelistRequestStatus: String
    let imageUrl, description: String?
}

struct Raw: Codable {
    let tokenUri: String
    let metadata: [String: String]
    let error: String?
}

struct ValidAt: Codable {
    let blockNumber: Int
    let blockHash: String
    let blockTimestamp: String
}
