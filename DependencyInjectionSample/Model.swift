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
    var delegate: UseCaseDelegate?

    private(set) var item: Item?

    func load() {
        let lastDate: Date?
        let lastTimeIntervalSince1970 = UserDefaults.standard.double(forKey: "lastTimeIntervalSince1970")
        if lastTimeIntervalSince1970 != 0 {
            lastDate = Date(timeIntervalSince1970: lastTimeIntervalSince1970)
        } else {
            lastDate = nil
        }
        let now = Date()

        item = Item(lastDate: lastDate, now: now)

        delegate?.useCaseDidLoad(self)

        saveCurrentDate()
    }

    func saveCurrentDate() {
        guard let now = item?.now else {
            assertionFailure("itemまだロードされてない")
            return
        }
        UserDefaults.standard.set(now.timeIntervalSince1970, forKey: "lastTimeIntervalSince1970")
    }
}
