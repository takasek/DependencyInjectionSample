//
//  MinimalCakePatternと似て非なるもの.swift
//  DependencyInjectionSample
//
//  Created by Yoshitaka Seki on 2018/04/02.
//  Copyright © 2018年 takasek. All rights reserved.
//

protocol UsesClock {
    var clock: Clock { get }
}

protocol UsesDateRepository {
    var dateRepository: DateRepositoryProtocol { get }
}
extension UsesDateRepository {
    var dateRepository: DateRepositoryProtocol {
        return DateRepositoryImpl()
    }
}

protocol UsesUseCase: UsesDateRepository, UsesClock {
    var useCase: UseCase { get }
}
extension UsesUseCase {
    var useCase: UseCase {
        return UseCase(dependency: .init(
            dateRepository: dateRepository,
            clock: clock
            ))
    }
}

protocol UsesPresenter: UsesUseCase {
    var presenter: Presenter { get }
}
extension UsesPresenter {
    var presenter: Presenter {
        return Presenter(dependency: .init(useCase: useCase))
    }
}

protocol UsesViewController: UsesPresenter {
    var viewController: ViewController { get }
}
extension UsesViewController {
    var viewController: ViewController {
        return ViewController.makeInstance(dependency: .init(presenter: presenter))
    }
}

struct ViewControllerService: UsesViewController {
    let clock: Clock
}
