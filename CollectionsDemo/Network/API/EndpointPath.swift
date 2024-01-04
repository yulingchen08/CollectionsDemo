//
//  EndpointPath.swift
//  CollectionsDemo
//
//  Created by 陳鈺翎 on 2024/1/3.
//

import Foundation

struct ApiConstants {
    // TODO: Need to encrypt API key, but this is not the focus of the current assignment. Will address this in a later update.
    static let apikey = "BqxcH1X0nbDP0LnkCVoOHcl1ENyncboD"
    static let owner = "0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045"
}


protocol EndpointPath {}

extension EndpointPath {
    var alchemy: String {
        "https://eth-mainnet.g.alchemy.com/nft/v3/"
    }
}

extension EndpointPath {
    func getNFTsForOwner() -> String {
        "\(ApiConstants.apikey)/getNFTsForOwner"
    }
}
