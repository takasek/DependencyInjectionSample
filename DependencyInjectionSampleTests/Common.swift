//
//  Common.swift
//  DependencyInjectionSampleTests
//
//  Created by Yoshitaka Seki on 2018/04/02.
//  Copyright © 2018年 takasek. All rights reserved.
//

@testable import DependencyInjectionSample

// Swinject の下準備
import Swinject
import SwinjectStoryboard
let testContainer: Container = {
    let c = Container(parent: SwinjectStoryboard.defaultContainer)
    c.register(DateRepositoryProtocol.self) { _ in
        MockDateRepositoryImpl(lastDate: nil)
    }
    return c
}()

// Minimal Cake Pattern の下準備
struct MockPresenterService: UsesViewController {
    let clock: Clock
    var dateRepository: DateRepositoryProtocol {
        return MockDateRepositoryImpl(lastDate: nil)
    }
}
struct MockViewControllerService: UsesViewController {
    let clock: Clock
    var dateRepository: DateRepositoryProtocol {
        return MockDateRepositoryImpl(lastDate: nil)
    }
}

// DIKit の下準備
import DIKit
struct TestResolver: AppResolver {
    func provideDateRepository() -> DateRepositoryProtocol {
        return MockDateRepositoryImpl(lastDate: nil)
    }
}
let testResolver = TestResolver()
