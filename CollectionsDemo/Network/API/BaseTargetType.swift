//
//  BaseTargetType.swift
//  CollectionsDemo
//
//  Created by 陳鈺翎 on 2024/1/3.
//

import Alamofire
import Foundation
import Moya

protocol ResponseTargetType: TargetType, EndpointPath {
    associatedtype ResponseType: Codable
    var endpoint: AlchemyEndpoint { get }
}

extension ResponseTargetType {
    var baseURL: URL {
        URL(string: endpoint.baseURL)!
    }

    var headers: [String: String]? {
        return [
            "accept": "application/json",
            "content-type": "application/json"
          ]
    }

    var sampleData: Data {
        "".data(using: String.Encoding.utf8)!
    }
}

