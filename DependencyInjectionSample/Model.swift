//
//  Model.swift
//  DependencyInjectionSample
//
//  Created by Yoshitaka Seki on 2018/03/25.
//  Copyright © 2018年 takasek. All rights reserved.
//

import Foundation

struct Item {
    let lastDate: Date?
    let now: Date
}

protocol UseCaseDelegate {
    func useCaseDidLoad(_ useCase: UseCase)
}

final class UseCase {
    struct Dependency {
        let dateRepository: DateRepositoryProtocol
        let now: Date
    }

    var delegate: UseCaseDelegate?

    private var dateRepository: DateRepositoryProtocol
    private let now: Date
    private(set) var item: Item?

    init(dependency: Dependency) {
        self.dateRepository = dependency.dateRepository
        self.now = dependency.now
    }

    func load() {
        let lastDate = dateRepository.fetchLastDate()

        item = Item(lastDate: lastDate, now: now)

        delegate?.useCaseDidLoad(self)

        saveCurrentDate()
    }

    func saveCurrentDate() {
        guard let now = item?.now else {
            assertionFailure("itemまだロードされてない")
            return
        }
        dateRepository.saveCurrentDate(now)
    }
}
