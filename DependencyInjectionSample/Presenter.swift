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

final class Presenter {
    struct Item {
        let lastDate: Date?
        let now: Date
    }
    private var item: Item?

    weak var delegate: PresenterDelegate?

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

        delegate?.presenterDidReceiveItem(self)

        saveCurrentDate()
    }

    var timeDescription: String? {
        guard let item = item else { return nil }

        let f = DateFormatter()
        f.setLocalizedDateFormatFromTemplate("kHms")

        return String(
            format: "last: %@\nnow: %@",
            item.lastDate.flatMap(f.string(from:)) ?? "--",
            f.string(from: item.now)
        )
    }

    func saveCurrentDate() {
        guard let now = item?.now else {
            assertionFailure("itemまだロードされてない")
            return
        }
        UserDefaults.standard.set(now.timeIntervalSince1970, forKey: "lastTimeIntervalSince1970")
    }
}
