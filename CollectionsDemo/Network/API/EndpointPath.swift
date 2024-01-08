//
//  EndpointPath.swift
//  CollectionsDemo
//
//  Created by 陳鈺翎 on 2024/1/3.
//

import Foundation

struct ApiConstants {
    /**
     Typically, we avoid embedding API keys directly into code for security reasons. However, for the sake of convenience during the review process, and as it is not the primary focus of the current assignment, the API key is hardcoded in this instance.
     */
    static let apikey = "BqxcH1X0nbDP0LnkCVoOHcl1ENyncboD"
    static let owner = "0x85fD692D2a075908079261F5E351e7fE0267dB02"
}

protocol EndpointPath {}

extension EndpointPath {
    func getNFTsForOwner() -> String {
        "\(ApiConstants.apikey)/getNFTsForOwner"
    }

    func getBalance() -> String {
        "\(ApiConstants.apikey)"
    }
}

enum AlchemyEndpoint {
    case nft
    case main

    var baseURL: String {
        switch self {
        case .nft:
            return "https://eth-goerli.g.alchemy.com/nft/v3/"
        case .main:
            return "https://eth-goerli.g.alchemy.com/v2/"
        }
    }
}
