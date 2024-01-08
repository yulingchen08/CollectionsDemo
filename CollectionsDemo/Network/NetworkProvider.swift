//
//  NetworkProvider.swift
//  CollectionsDemo
//
//  Created by 陳鈺翎 on 2024/1/3.
//

import Moya

class NetworkProvider<Target>: MoyaProvider<Target> where Target: TargetType {
    init(
        endpointClosure: @escaping EndpointClosure = MoyaProvider.defaultEndpointMapping,
        stubClosure: @escaping StubClosure = MoyaProvider.neverStub,
        plugins: [PluginType] = []
    ) {
        super.init(
            endpointClosure: endpointClosure,
            requestClosure: MoyaProvider<Target>.defaultRequestMapping,
            stubClosure: stubClosure,
            callbackQueue: nil,
            session: Session(),
            plugins: plugins,
            trackInflights: false
        )
    }
}
