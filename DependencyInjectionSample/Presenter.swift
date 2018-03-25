//
//  Presenter.swift
//  DependencyInjectionSample
//
//  Created by Yoshitaka Seki on 2018/03/25.
//  Copyright © 2018年 takasek. All rights reserved.
//

import Foundation

protocol PresenterDelegate: class {
    func presenterDidReceiveItem(_ presenter: Presenter)
}

final class Presenter: UseCaseDelegate {
    let useCase: UseCase
    weak var delegate: PresenterDelegate?

    init() {
        useCase = UseCase()
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
