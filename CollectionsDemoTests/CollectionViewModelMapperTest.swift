//
//  CollectionViewModelMapperTest.swift
//  CollectionsDemoTests
//
//  Created by 陳鈺翎 on 2024/1/5.
//

import RxSwift
import XCTest
@testable import CollectionsDemo

final class CollectionViewModelMapperTest: XCTestCase {
    
    var sut: CollectionViewModelMapping!
    
    override func setUpWithError() throws {
        sut = CollectionViewModelMapper()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testMapResponse() throws {
        let response = NftApiResponse.mock
        let viewModel = sut.map(response: response)
        XCTAssertEqual(viewModel.galleries.count, 1)
        XCTAssertEqual(viewModel.galleries[0].contractName, "Contract name")
        XCTAssertEqual(viewModel.galleries[0].name, "Mona Lisa Smile")
        XCTAssertEqual(viewModel.galleries[0].description, "Mona Lisa Smile is a 2003 American drama film produced by Revolution Studios")
        XCTAssertEqual(viewModel.galleries[0].imageUrl, "https:xxx")
    }
}
