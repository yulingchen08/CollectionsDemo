//
//  CollectionListViewModel.swift
//  CollectionsDemo
//
//  Created by 陳鈺翎 on 2024/1/5.
//

import Foundation
import RxSwift

protocol CollectionListViewModelInputsType {
    func fetchMoreCollections()
    func initializeDataFetch()
}

protocol CollectionListViewModelOutputsType: AnyObject {
    var presentCollectionCell: (() -> Void) { get set }
}

protocol PlaylistViewModelType {
    var inputs: CollectionListViewModelInputsType { get }
    var outputs: CollectionListViewModelOutputsType { get }
}

class CollectionListViewModel: PlaylistViewModelType,
                               CollectionListViewModelInputsType,
                               CollectionListViewModelOutputsType {
    private enum Constants {
        static let initialLoadCount = 20
        static let nextPageLoadCount = 20
    }

    var inputs: CollectionListViewModelInputsType { return self }
    var outputs: CollectionListViewModelOutputsType { return self }
    
    var nftRepository: NftRepositoryProtocol
    let disposeBag = DisposeBag()
    var dataSource: CollectionViewModel = .init(
        galleries: [],
        pageKey: nil,
        totalCount: 0
    )
    
    init(nftRepository: NftRepositoryProtocol) {
        self.nftRepository = nftRepository
    }
    
    //MARK: - Inputs
    func fetchMoreCollections() {
        let remainingCount = dataSource.totalCount - dataSource.galleries.count
        let size = remainingCount >= Constants.nextPageLoadCount ? Constants.nextPageLoadCount: remainingCount
        guard size > 0 else { return }
        updateCollection(pageSize: size)
    }
    
    func initializeDataFetch() {
        updateCollection(pageSize: Constants.initialLoadCount)
    }
    
    var presentCollectionCell: (() -> Void) = {}
}

extension CollectionListViewModel {
    private func updateCollection(pageSize: Int) {
        nftRepository.getNFTsForOwner(
            pageSize: pageSize,
            pageKey: dataSource.pageKey
        )
        .subscribe { [weak self] collectionViewModel in
            self?.dataSource.pageKey = collectionViewModel.pageKey
            self?.dataSource.galleries.append(contentsOf: collectionViewModel.galleries)
            self?.dataSource.totalCount = collectionViewModel.totalCount
            self?.outputs.presentCollectionCell()
        } onFailure: { error in
            print("[Error] updateCollection error: \(error.localizedDescription)")
        }.disposed(by: disposeBag)
    }
}
