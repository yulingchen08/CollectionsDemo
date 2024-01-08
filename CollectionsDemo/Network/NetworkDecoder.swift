//
//  NetworkDecoder.swift
//  CollectionsDemo
//
//  Created by 陳鈺翎 on 2024/1/3.
//

import Foundation

struct NetworkDecoder {
    static func decode<T: Decodable>(
        _ type: T.Type,
        from data: Data?
    ) throws -> T {
        guard let from = data else {
            throw NetworkError.responseDataIsNull
        }
        do {
            let response = try JSONDecoder().decode(T.self, from: from)
            return response
        } catch {
            print("[Error] Api response decoding failed: \(error)")
            throw error
        }
    }
}
