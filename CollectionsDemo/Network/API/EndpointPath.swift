//
//  EndpointPath.swift
//  CollectionsDemo
//
//  Created by 陳鈺翎 on 2024/1/3.
//

import Foundation

struct ApiConstants {
    static let address = "0x85fD692D2a075908079261F5E351e7fE0267dB02"
    static let chain = "goerli"
}


protocol EndpointPath {}

extension EndpointPath {
    var testnets: String {
        "https://testnets-api.opensea.io/api/v2/"
    }
}

extension EndpointPath {
    func nfts() -> String {
        "chain/\(ApiConstants.chain)/account/\(ApiConstants.address)/nfts"
    }
}
