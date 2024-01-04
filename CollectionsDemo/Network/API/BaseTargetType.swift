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
}

extension ResponseTargetType {
    var baseURL: URL {
        URL(string: alchemy)!
    }

    var headers: [String: String]? {
        return nil
    }

    var sampleData: Data {
        "".data(using: String.Encoding.utf8)!
    }
}

