//
//  NFTsAPI.swift
//  CollectionsDemo
//
//  Created by 陳鈺翎 on 2024/1/3.
//

import Foundation
import Moya

struct NftsApi {
    struct getNFTsForOwner: ResponseTargetType {
        typealias ResponseType = NftApiResponse
        
        var endpoint: AlchemyEndpoint = .nft
        private let pageSize: Int
        private let pageKey: String?
        
        var path: String {
            getNFTsForOwner()
        }
        
        var method: Moya.Method {
            .get
        }
        
        var task: Task {
            var parameters: [String: Any] = [
                "owner": ApiConstants.owner,
                "withMetadata": "true",
                "pageSize": pageSize
            ]
            
            if let pageKey = pageKey {
                parameters["pageKey"] = pageKey
            }
            return .requestParameters(
                parameters: parameters,
                encoding: URLEncoding.queryString
            )
        }
        
        init(
            pageSize: Int,
            pageKey: String?
        ) {
            self.pageSize = pageSize
            self.pageKey = pageKey
        }
    }
    
    struct getBalance: ResponseTargetType {
        typealias ResponseType = GetBalanceResponse

        var endpoint: AlchemyEndpoint = .main

        var path: String {
            getBalance()
        }
        
        var method: Moya.Method {
            .post
        }
        
        var task: Task {
            let parameters: [String: Any] = [
                "id": 1,
                "jsonrpc": "2.0",
                "params": [
                    ApiConstants.owner,
                    "latest"],
                "method": "eth_getBalance"
            ]
            return .requestParameters(
                parameters: parameters,
                encoding: JSONEncoding.default
            )
        }
    }
}
