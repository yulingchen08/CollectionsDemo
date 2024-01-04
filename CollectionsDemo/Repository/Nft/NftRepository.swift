//
//  NftRepository.swift
//  CollectionsDemo
//
//  Created by 陳鈺翎 on 2024/1/4.
//

import Foundation
import RxSwift

protocol NftRepositoryProtocol: AnyObject {
    func getNFTsForOwner(pageSize: Int) -> Single<CollectionViewModel>
}

class NftRepository: BaseRepository {
    private let viewModelMapper: CollectionViewModelMapper
    init(viewModelMapper: CollectionViewModelMapper) {
        self.viewModelMapper = viewModelMapper
    }
}

extension NftRepository: NftRepositoryProtocol {
    func getNFTsForOwner(pageSize: Int) -> Single<CollectionViewModel> {
        let request = NftsApi.getNFTsForOwner(pageSize: 1)
        return network.request(request)
            .flatMap { [unowned self] response in
                let viewModel = self.viewModelMapper.map(response: response)
                return Single.just(viewModel)
            }
    }
}
