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
        
        var path: String {
            getNFTsForOwner()
        }
        
        var method: Moya.Method {
            .get
        }
        
        var task: Task {
            let parameters: [String: Any] = [
                "owner": ApiConstants.owner,
                "withMetadata": "true",
                "pageSize": pageSize
            ]
            return .requestParameters(
                parameters: parameters,
                encoding: URLEncoding.queryString
            )
        }
        
        init(pageSize: Int) {
            self.pageSize = pageSize
        }
    }
}
