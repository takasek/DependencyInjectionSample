//
//  DIKit.swift
//  DependencyInjectionSample
//
//  Created by Yoshitaka Seki on 2018/04/02.
//  Copyright © 2018年 takasek. All rights reserved.
//

import DIKit

protocol AppResolver: Resolver {
    func provideDateRepository() -> DateRepositoryProtocol
}

final class AppResolverImpl: AppResolver {
    func provideDateRepository() -> DateRepositoryProtocol {
        return DateRepositoryImpl()
    }
}
