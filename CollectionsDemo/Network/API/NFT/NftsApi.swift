//
//  NFTsAPI.swift
//  CollectionsDemo
//
//  Created by 陳鈺翎 on 2024/1/3.
//

import Foundation
import Moya

struct NftsApi {
    struct getNfts: ResponseTargetType {
        typealias ResponseType = CollectionDTO.Collection
        
        private let limit: Int
        
        var path: String {
            nfts()
        }
        
        var method: Moya.Method {
            .get
        }
        
        var task: Task {
            let parameters: [String: Any] = ["limit": "\(limit)"]
            return .requestParameters(
                parameters: parameters,
                encoding: URLEncoding.queryString
            )
        }
        
        init(limit: Int) {
            self.limit = limit
        }
    }
}
