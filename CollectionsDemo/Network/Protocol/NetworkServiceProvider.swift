//
//  NetworkServiceProvider.swift
//  CollectionsDemo
//
//  Created by 陳鈺翎 on 2024/1/3.
//

import Moya
import RxSwift

protocol NetworkServiceProvider {
    func request<R: ResponseTargetType>(_ request: R) -> Single<R.ResponseType>
}

extension NetworkServiceProvider {
    func request<R: ResponseTargetType>(_ request: R) -> Single<R.ResponseType> {
        return self.request(request)
    }
}

