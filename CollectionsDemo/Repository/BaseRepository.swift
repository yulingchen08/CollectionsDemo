//
//  BaseRepository.swift
//  CollectionsDemo
//
//  Created by 陳鈺翎 on 2024/1/5.
//

import Foundation
import RxCocoa
import RxSwift

class BaseRepository {
    var network: NetworkServiceProviding
    var disposeBag = DisposeBag()
    
    init(network: NetworkServiceProviding = NetworkService.shared) {
        self.network = network
    }
}
