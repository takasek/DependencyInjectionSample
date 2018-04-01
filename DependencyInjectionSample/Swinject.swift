//
//  Swinject.swift
//  DependencyInjectionSample
//
//  Created by Yoshitaka Seki on 2018/04/02.
//  Copyright © 2018年 takasek. All rights reserved.
//

import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {
    @objc class func setup() {
        defaultContainer.register(DateRepositoryProtocol.self) { _ in
            DateRepositoryImpl()
        }
        defaultContainer.register(UseCase.self) { r, clock in
            UseCase(dependency: .init(
                dateRepository: r.resolve(DateRepositoryProtocol.self)!,
                clock: clock
                ))
        }
        defaultContainer.register(Presenter.self) { (r: Resolver, clock: Clock) in
            Presenter(dependency: .init(
                useCase: r.resolve(UseCase.self, argument: clock)!
                ))
        }
        // SwinjectStoryboard のすごいところ
        // StoryboardでVCが作られたタイミングでフックを掛けて プロパティ・インジェクションできる
        defaultContainer.storyboardInitCompleted(ViewController.self) { r, vc in
            let clock = r.resolve(Clock.self, name: "ViewController")!
            vc.presenter = r.resolve(Presenter.self, argument: clock)!
        }
        // 型に加えて name を指定してregisterもできる
        defaultContainer.register(Clock.self, name: "ViewController") { _ in
            return SystemClock()
        }
    }
}

