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
    var network: NetworkService = .shared
    var disposeBag = DisposeBag()
}
