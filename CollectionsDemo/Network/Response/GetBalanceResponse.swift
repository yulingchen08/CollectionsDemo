//
//  GetBalanceResponse.swift
//  CollectionsDemo
//
//  Created by 陳鈺翎 on 2024/1/8.
//

import Foundation

struct GetBalanceResponse: Codable {
    let jsonrpc: String
    let id: Int
    let result: String
}
