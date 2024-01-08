//
//  CollectionListViewModel.swift
//  CollectionsDemo
//
//  Created by 陳鈺翎 on 2024/1/5.
//

import Foundation
import RxSwift

protocol CollectionListViewModelInputsType {
    var dataSource: CollectionViewModel { get set }
    func onViewDidLoad()
    func fetchMoreCollections()
}

protocol CollectionListViewModelOutputsType: AnyObject {
    var presentCollectionCell: (() -> Void) { get set }
    var updateBalance:((String?) -> Void) { get set }
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

    // MARK: - Inputs
    func onViewDidLoad() {
        updateCollection(pageSize: Constants.initialLoadCount)
        fetchBalance()
    }

    func fetchMoreCollections() {
        let remainingCount = dataSource.totalCount - dataSource.galleries.count
        let size = remainingCount >= Constants.nextPageLoadCount ? Constants.nextPageLoadCount: remainingCount
        guard size > 0 else { return }
        updateCollection(pageSize: size)
    }

    var presentCollectionCell: (() -> Void) = {}
    var updateBalance:((String?) -> Void) = {_ in }
}

private extension CollectionListViewModel {
    func fetchBalance() {
        nftRepository.getBalance()
            .subscribe { [weak self] balance in
                let convertedBalance = self?.convertBalance(with: balance)
                self?.outputs.updateBalance(convertedBalance)
            } onFailure: { error in
                print("[Error] getBalance error: \(error.localizedDescription)")
            }.disposed(by: disposeBag)
    }

    func updateCollection(pageSize: Int) {
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

    func convertBalance(with hexString: String) -> String {
        var cleanedHexString = hexString
        if hexString.hasPrefix("0x") {
            cleanedHexString = String(hexString.dropFirst(2))
        }

        guard let intValue = Int(
            cleanedHexString,
            radix: 16
        ) else {
            return "no data"
        }

        return String(intValue)
    }
}
