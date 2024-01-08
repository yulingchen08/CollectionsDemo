//
//  NetworkService.swift
//  CollectionsDemo
//
//  Created by 陳鈺翎 on 2024/1/3.
//

import Alamofire
import Moya
import RxSwift
import Foundation

public class NetworkService: NetworkServiceProviding {
    private let provider: NetworkProvider<MultiTarget>
    private var networkReachabilityManager = NetworkReachabilityManager()

    init(provider: NetworkProvider<MultiTarget>) {
        self.provider = provider
    }

    func request<R: ResponseTargetType>(_ request: R) -> Single<R.ResponseType> {
        let t1 = Date()
        let target = MultiTarget(request)
        NetworkPrinter.printRequestInfo(
            T1: t1,
            target: target
        )

        return chenkIsNetworkReachable()
            .request(
                provider: provider,
                target: target
            )
            .checkHttpError()
            .printResponse(
                t1: t1,
                target: target
            )
            .decodeToResponseType(R.ResponseType.self)
    }
}

// MARK: - Check Is Network Reachable
extension NetworkService {
    private func chenkIsNetworkReachable() -> Single<Void> {
        if let manager = networkReachabilityManager {
            if manager.isReachable {
                return Single<Void>.just(())
            }
        } else {
            networkReachabilityManager = NetworkReachabilityManager()
        }

        let error = NetworkError.notReachable
        return Single.error(error)
    }
}

// MARK: - Request
extension PrimitiveSequenceType where Self.Trait == RxSwift.SingleTrait {
    func request(
        provider: NetworkProvider<MultiTarget>,
        target: MultiTarget,
        progressHandler: ((ProgressResponse?) -> Void)? = nil
    ) -> Single<Result<Response, MoyaError>> {
        Single<Result<Response, MoyaError>>.create { singleObserver in

            let cancellableToken = provider.request(target) { progress in
                progressHandler?(progress)
            } completion: { complete in
                singleObserver(.success(complete))
            }

            return Disposables.create {
                cancellableToken.cancel()
            }
        }.subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
    }
}

// MARK: - Check HTTP Error
extension PrimitiveSequenceType
where Self.Trait == RxSwift.SingleTrait,
      Self.Element == Result<Response, MoyaError> {
    func checkHttpError() -> Single<Response> {
        primitiveSequence.flatMap { complete -> Single<Response> in
            switch complete {
            case let .success(response):
                return Single.just(response)
            case let .failure(error):
                return Single.error(NetworkError.httpError(error: error))
            }
        }
    }
}

extension PrimitiveSequenceType
where Self.Trait == RxSwift.SingleTrait,
      Self.Element == Response {
    func printResponse(
        t1: Date,
        target: MultiTarget
    ) -> Single<Response> {
        flatMap { response -> Single<Response> in
            let t4 = Date()

            NetworkPrinter.printResponseInfo(
                T1: t1,
                T4: t4,
                target: target,
                response: response
            )

            return Single.just(response)
        }
    }

    func decodeToResponseType<C: Decodable>(_ type: C.Type) -> Single<C> {
        flatMap { response -> Single<C> in
            do {
                let dto = try NetworkDecoder.decode(
                    C.self,
                    from: response.data
                )
                return Single<C>.just(dto)
            } catch {
                let decodeError = NetworkError.decodeError(
                    error: error,
                    requestURL: response.request?.url
                )
                return Single.error(decodeError)
            }
        }
    }
}
