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
}

extension CollectionViewModel {
    static var mock: CollectionViewModel {
        CollectionViewModel(
            galleries: [
                Gallery(
                    contractName: "A contract name",
                    name: "A name"
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
                    contractName: "contract1",
                    name: "name1"
                ),
                Gallery(
                    contractName: "contract2",
                    name: "name2"
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
                    contractName: "contract1",
                    name: "name1"
                ),
                Gallery(
                    contractName: "contract2",
                    name: "name2"
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
                    contractName: "contract one",
                    name: "name one"
                ),
                Gallery(
                    contractName: "contract two",
                    name: "name two"
                )
            ],
            pageKey: "key",
            totalCount: 30
        )
    }
}
