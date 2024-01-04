//
//  NetworkError.swift
//  CollectionsDemo
//
//  Created by 陳鈺翎 on 2024/1/3.
//

import Foundation
import Moya


enum NetworkError: Error {
    case notReachable
    case httpError(error: MoyaError)
    case responseDataIsNull
    case insideResponseCode(
        originResponse: Response,
        code: Int
    )
    case decodeError(
        error: Error,
        requestURL: URL?
    )
    
    public var errorDomain: String {
        switch self {
        case .notReachable:
            return "Network-NotReachable"
        case .httpError:
            return "Network-HttpCode"
        case .insideResponseCode:
            return "Network-ResponseCode"
        case .decodeError:
            return "Network-Decode"
        case .responseDataIsNull:
            return "Network-ResponseDataIsNull"
        }
    }
    
    public var errorMessage: String {
        switch self {
        case .notReachable:
            return "No Internet connection. Check your connection and try again."
        case .httpError:
            return "Something went wrong. Please try again."
        case .responseDataIsNull:
            return "Something went wrong. Please try again."
        case .insideResponseCode:
            return "Something went wrong. Please try again."
        case .decodeError:
            return "Something went wrong. Please try again."
        }
    }
}
