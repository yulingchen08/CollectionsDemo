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
}
