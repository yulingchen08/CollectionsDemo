//
//  SharedTestHelpers.swift
//  CollectionsDemoTests
//
//  Created by 陳鈺翎 on 2024/1/5.
//

import Foundation
import Moya
import RxSwift
@testable import CollectionsDemo

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}

func anyURLString() -> String {
    return "http://any-url.com"
}

func anyDate() -> Date {
    return Date()
}

func anyBaseResponse() -> BaseResponse {
    return BaseResponse(statusCode: 200)
}

func makeSampleData<T: Encodable>(_ value: T) -> Data {
    return try! JSONEncoder().encode(value)
}
