//
//  NftRepositoryMock.swift
//  CollectionsDemoTests
//
//  Created by 陳鈺翎 on 2024/1/7.
//

import Foundation
import RxSwift
@testable import CollectionsDemo

class NftRepositoryMock: NftRepositoryProtocol {

    private var shouldReturnError: Bool = false

    func setShouldReturnError(_ shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }

    func getNFTsForOwner(pageSize: Int, pageKey: String?) -> Single<CollectionViewModel> {
        if shouldReturnError {
            return Single.error(NSError(domain: "MockErrorDomain", code: 1, userInfo: nil))
        } else {
            let viewModel: CollectionViewModel = .mock
            sleep(1)
            return Single.just(viewModel)
        }
    }

    func getBalance() -> RxSwift.Single<String> {
        Single.just("1234567")
    }
}

extension CollectionViewModel {
    static var mock: CollectionViewModel {
        CollectionViewModel(
            galleries: [
                Gallery(
                    tokenId: "A tokenId",
                    contractName: "A contractName",
                    address: "A address",
                    name: "A name", contentType: .svg
                )
            ],
            pageKey: "key",
            totalCount: 1
        )
    }

    static var mockWithRemainingCount: CollectionViewModel {
        CollectionViewModel(
            galleries: [
                Gallery(
                    tokenId: "tokenId1",
                    contractName: "contract1",
                    address: "address1",
                    name: "name1", contentType: .png
                ),
                Gallery(
                    tokenId: "tokenId2",
                    contractName: "contract2",
                    address: "address2",
                    name: "name2",
                    contentType: .png
                )
            ],
            pageKey: "key",
            totalCount: 3
        )
    }

    static var mockWithoutRemainingCount: CollectionViewModel {
        CollectionViewModel(
            galleries: [
                Gallery(
                    tokenId: "tokenId1",
                    contractName: "contract1",
                    address: "address1",
                    name: "name1",
                    contentType: .png
                ),
                Gallery(
                    tokenId: "tokenId2",
                    contractName: "contract2",
                    address: "address2",
                    name: "name2",
                    contentType: .png
                )
            ],
            pageKey: "key",
            totalCount: 2
        )
    }

    static var mockWithMoreRemainingCount: CollectionViewModel {
        CollectionViewModel(
            galleries: [
                Gallery(
                    tokenId: "token one",
                    contractName: "contract one",
                    address: "address one",
                    name: "name one",
                    contentType: .png
                ),
                Gallery(
                    tokenId: "token two",
                    contractName: "contract two",
                    address: "address two",
                    name: "name two",
                    contentType: .png
                )
            ],
            pageKey: "key",
            totalCount: 30
        )
    }
}
