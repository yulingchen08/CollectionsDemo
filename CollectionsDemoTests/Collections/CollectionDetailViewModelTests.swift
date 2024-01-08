//
//  CollectionDetailViewModelTests.swift
//  CollectionsDemoTests
//
//  Created by 陳鈺翎 on 2024/1/8.
//

import XCTest
@testable import CollectionsDemo

final class CollectionDetailViewModelTests: XCTestCase {
    private var sut: CollectionDetailViewModel!
    
    override func setUpWithError() throws {
        let gallery: Gallery = .mock
        sut = CollectionDetailViewModel(gallery: gallery)
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testGetOpenseaLink() {
        let openseaLink = sut.inputs.getOpenseaLink()
        
        XCTAssertNotNil(openseaLink)
        XCTAssertEqual(openseaLink?.absoluteString, "https://testnets.opensea.io/assets/goerli/name1/address1")
    }
}

extension Gallery {
    static var mock: Gallery {
        Gallery(
            tokenId: "address1",
            contractName: "tokenId1",
            address: "name1",
            name: "www.google.com",
            description: "descritption1",
            contentType: .svg
        )
    }
}
