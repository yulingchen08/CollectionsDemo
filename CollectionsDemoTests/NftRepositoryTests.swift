//
//  NftRepositoryTests.swift
//  CollectionsDemoTests
//
//  Created by 陳鈺翎 on 2024/1/5.
//


import RxSwift
import XCTest
@testable import CollectionsDemo

final class NftRepositoryTests: XCTestCase {
    var sut: NftRepository!
    var network: NetworkServiceStub!
    let disposeBag = DisposeBag()
    
    override func setUpWithError() throws {
        (sut, network) = makeSUT()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        network = nil
    }
    
    func testGetNFTsForOwnerSucceeded() throws {
        let data = makeSampleData(NftApiResponse.mock)
        let exp = expectation(description: "testGetNFTsForOwnerSuccess expectation")
        network.completeRequestSuccessfully(data: data)
        var viewModels = [CollectionViewModel]()
        
        sut.getNFTsForOwner(pageSize: 1)
            .subscribe { viewModel in
                viewModels.append(viewModel)
                exp.fulfill()
            } onFailure: { error in
                XCTFail("Expected success, but got onFailure with error: \(error.localizedDescription)")
            }.disposed(by: disposeBag)
        
        wait(for: [exp], timeout: 1.0)
        
        XCTAssertEqual(viewModels.count, 1)
        XCTAssertEqual(viewModels[0].galleries.count, 1)
        XCTAssertEqual(viewModels[0].galleries[0].contractName, "contractName")
        XCTAssertEqual(viewModels[0].galleries[0].name, "name")
        let description = try XCTUnwrap(viewModels[0].galleries[0].description)
        XCTAssertEqual(description, "description")
    }
    
    func testGetNFTsForOwnerFailed() throws {
        let exp = expectation(description: "testGetNFTsForOwnerFailed expectation")
        network.completeRequest(with: anyNSError())
        var receivedError: Error?
        
        sut.getNFTsForOwner(pageSize: 1)
            .subscribe { _ in
            } onFailure: { error in
                receivedError = error
                exp.fulfill()
            }.disposed(by: disposeBag)
        wait(for: [exp], timeout: 1.0)
        
        XCTAssertNotNil(receivedError, "Recevied any errors")
    }
}

extension NftRepositoryTests {
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: NftRepository, network: NetworkServiceStub) {
        let network = NetworkServiceStub()
        let mapper = CollectionViewModelMapperMock()
        let sut = NftRepository(
            viewModelMapper: mapper,
            network: network
        )
        return (sut, network)
    }
}

extension NftApiResponse {
    static var mock: NftApiResponse {
        NftApiResponse(
            ownedNfts: [
                OwnedNft(
                    contract: Contract(
                        address: "",
                        name: "Contract name",
                        symbol: "",
                        totalSupply: nil,
                        tokenType: "",
                        contractDeployer: "",
                        deployedBlockNumber: 0,
                        openSeaMetadata: OpenSeaMetadata(
                            floorPrice: 0,
                            collectionName: "Mona Lisa Smile",
                            collectionSlug: "",
                            safelistRequestStatus: "",
                            imageUrl: "https:xxx",
                            description: "Mona Lisa Smile is a 2003 American drama film produced by Revolution Studios"
                        ),
                        isSpam: false,
                        spamClassifications: []
                    ),
                    tokenId: nil,
                    tokenType: nil,
                    name: nil,
                    description: nil,
                    tokenUri: "",
                    image: Image(
                        cachedUrl: nil,
                        thumbnailUrl: nil,
                        pngUrl: nil,
                        contentType: nil,
                        size: nil,
                        originalUrl: nil
                    ),
                    raw: Raw(
                        tokenUri: "",
                        metadata: [:],
                        error: nil
                    ),
                    collection: Collection(
                        name: nil,
                        slug: nil,
                        externalUrl: nil,
                        bannerImageUrl: nil
                    ),
                    owners: nil,
                    timeLastUpdated: "",
                    balance: ""
                )
            ],
            totalCount: 1,
            validAt: ValidAt(
                blockNumber: 0,
                blockHash: "",
                blockTimestamp: ""
            ),
            pageKey: ""
        )
    }
}
