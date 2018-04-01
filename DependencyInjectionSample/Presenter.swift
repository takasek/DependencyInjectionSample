//
//  Presenter.swift
//  DependencyInjectionSample
//
//  Created by Yoshitaka Seki on 2018/03/25.
//  Copyright © 2018年 takasek. All rights reserved.
//

import Foundation
import DIKit

protocol PresenterDelegate: class {
    func presenterDidReceiveItem(_ presenter: Presenter)
}

final class Presenter: UseCaseDelegate, Injectable {
    struct Dependency {
        let useCase: UseCase
    }

    let useCase: UseCase
    weak var delegate: PresenterDelegate?

    init(dependency: Dependency) {
        useCase = dependency.useCase
        useCase.delegate = self
    }

    func load() {
        useCase.load()
    }

    func useCaseDidLoad(_ useCase: UseCase) {
        delegate?.presenterDidReceiveItem(self)
    }

    var timeDescription: String? {
        guard let item = useCase.item else { return nil }

        let f = DateFormatter()
        f.setLocalizedDateFormatFromTemplate("kHms")

        return String(
            format: "last: %@\nnow: %@",
            item.lastDate.flatMap(f.string(from:)) ?? "--",
            f.string(from: item.now)
        )
    }
}
