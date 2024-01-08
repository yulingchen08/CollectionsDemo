//
//  NetworkServiceStub.swift
//  CollectionsDemoTests
//
//  Created by 陳鈺翎 on 2024/1/5.
//

import Foundation
import Moya
import RxSwift
@testable import CollectionsDemo

class NetworkServiceStub: NetworkServiceProviding {
    private var endpointClosure: NetworkProvider<MultiTarget>.EndpointClosure?

    func completeRequestSuccessfully(data: Data) {
        endpointClosure(
            isSuccessed: true,
            data: data
        )
    }

    func completeRequest(with error: NSError) {
        endpointClosure(
            isSuccessed: false,
            error: error
        )
    }

    func request<R: ResponseTargetType>(_ request: R) -> Single<R.ResponseType> {
        let target = MultiTarget(request)

        return Single<Void>.just(())
            .request(
                provider: NetworkProvider<MultiTarget>(
                    endpointClosure: endpointClosure!,
                    stubClosure: MoyaProvider.immediatelyStub
                ),
                target: target
            )
            .checkHttpError()
            .decodeToResponseType(R.ResponseType.self)
    }

    private func endpointClosure(
        isSuccessed: Bool,
        data: Data? = nil,
        error: NSError? = nil
    ) {
        endpointClosure = { target -> Endpoint in
            let expectedError = error ?? anyNSError()
            let sampleData = data ?? Data()
            let sampleResponse: EndpointSampleResponse = isSuccessed ?
                .networkResponse(200, sampleData) : .networkError(expectedError)
            return Endpoint(
                url: URL(target: target).absoluteString,
                sampleResponseClosure: { sampleResponse },
                method: target.method,
                task: target.task,
                httpHeaderFields: target.headers
            )
        }
    }
}
