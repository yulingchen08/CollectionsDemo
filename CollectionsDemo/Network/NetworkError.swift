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
        case .decodeError:
            return "Network-Decode"
        case .responseDataIsNull:
            return "Network-ResponseDataIsNull"
        }
    }

    public var errorMessage: String {
        switch self {
        case .notReachable:
            return "error_not_reachable".localized
        case .httpError:
            return "error_http_error".localized
        case .responseDataIsNull:
            return "error_response_data_nil".localized
        case .decodeError:
            return "error_decode".localized
        }
    }
}
