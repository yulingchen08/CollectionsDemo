//
//  CollectionListViewModel.swift
//  CollectionsDemo
//
//  Created by 陳鈺翎 on 2024/1/5.
//

import Foundation
import RxSwift

protocol CollectionListViewModelInputsType {
    func scrollToBottom()
    func loadData()
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
    var inputs: CollectionListViewModelInputsType { return self }
    var outputs: CollectionListViewModelOutputsType { return self }
    
    func scrollToBottom() {
    }
    
    func loadData() {
    }
    
    var presentCollectionCell: (() -> Void) = {}
}
