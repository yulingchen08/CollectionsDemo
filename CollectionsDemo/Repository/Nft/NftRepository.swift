//
//  NftRepository.swift
//  CollectionsDemo
//
//  Created by 陳鈺翎 on 2024/1/4.
//

import Foundation
import RxSwift

protocol NftRepositoryProtocol: AnyObject {
    func getNFTsForOwner(
        pageSize: Int,
        pageKey: String?
    ) -> Single<CollectionViewModel>
    func getBalance() -> Single<String>
}

class NftRepository: BaseRepository {
    private let viewModelMapper: CollectionViewModelMapping
    init(
        viewModelMapper: CollectionViewModelMapping,
        network: NetworkServiceProviding
    ) {
        self.viewModelMapper = viewModelMapper
        super.init(network: network)
    }
}

extension NftRepository: NftRepositoryProtocol {
    func getNFTsForOwner(
        pageSize: Int,
        pageKey: String?
    ) -> Single<CollectionViewModel> {
        let request = NftsApi.GetNFTsForOwner(
            pageSize: pageSize,
            pageKey: pageKey
        )
        return network.request(request)
            .flatMap { [unowned self] response in
                let viewModel = self.viewModelMapper.map(response: response)
                return Single.just(viewModel)
            }
    }

    func getBalance() -> Single<String> {
        let request = NftsApi.GetBalance()
        return network.request(request)
            .flatMap { response in
                Single.just(response.result)
            }
    }
}
