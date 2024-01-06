//
//  DependencyContainer.swift
//  CollectionsDemo
//
//  Created by 陳鈺翎 on 2024/1/6.
//

import Foundation
import Moya
import Swinject
import SwinjectAutoregistration


class DependencyContainer {
    static let shared = DependencyContainer()
    
    let container: Container
    lazy var synchronizedResolver = container.synchronize()

    private init() {
        container = Container()
        registerDependencies()
    }
    
    func getService<Service>() -> Service {
      guard let service = synchronizedResolver.resolve(Service.self) else {
        fatalError("Cannot resolve service of type \(Service.self)")
      }
      return service
    }
    
    private func registerDependencies() {
        container.register(NetworkProvider<MultiTarget>.self) { resolver in
            return NetworkProvider<MultiTarget>()
        }

        container.register(NetworkServiceProviding.self) { resolver in
            NetworkService(provider: resolver.resolve(NetworkProvider.self)!)
        }
        
        container.autoregister(
            CollectionViewModelMapping.self,
            initializer: CollectionViewModelMapper.init
        )
        
        container.register(NftRepositoryProtocol.self) { resolver in
            NftRepository(
                viewModelMapper: resolver~>,
                network: resolver~>
            )
        }
    }
}
