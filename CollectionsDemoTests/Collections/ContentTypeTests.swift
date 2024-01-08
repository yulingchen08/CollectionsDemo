//
//  ContentTypeTests.swift
//  CollectionsDemoTests
//
//  Created by 陳鈺翎 on 2024/1/8.
//

import XCTest
@testable import CollectionsDemo

final class ContentTypeTests: XCTestCase {

    func testContentTypeDecoding() throws {
        let json = """
           "image/png"
           """

        let decodedContentType = try JSONDecoder().decode(ContentType.self, from: json.data(using: .utf8)!)

        XCTAssertEqual(decodedContentType, .png)
    }

    func testContentTypeEncoding() throws {
        let contentType = ContentType.svg

        let encodedData = try JSONEncoder().encode(contentType)
        let encodedString = String(data: encodedData, encoding: .utf8)?.replacingOccurrences(of: "\\", with: "")

        XCTAssertEqual(encodedString, "\"image/svg+xml\"")
    }
}
