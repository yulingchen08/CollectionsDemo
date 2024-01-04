//
//  CollectionDTO.swift
//  CollectionsDemo
//
//  Created by 陳鈺翎 on 2024/1/3.
//

import Foundation

struct CollectionDTO {
    struct Collection: Codable {
        let nfts: [NFT]
    }
    
    struct NFT: Codable {
        let identifier: String
        let collection: String
        let contract: String
        let tokenStandard: String
        let name: String
        let description: String
        let imageUrl: String?
        let metadataUrl: String
        let openseaUrl: String
        let updatedAt: String
        let isDisabled: Bool
        let isNSFW: Bool
        let traits: String?

        enum CodingKeys: String, CodingKey {
            case identifier
            case collection
            case contract
            case tokenStandard = "token_standard"
            case name
            case description
            case imageUrl = "image_url"
            case metadataUrl = "metadata_url"
            case openseaUrl = "opensea_url"
            case updatedAt = "updated_at"
            case isDisabled = "is_disabled"
            case isNSFW = "is_nsfw"
            case traits
        }
    }
}
