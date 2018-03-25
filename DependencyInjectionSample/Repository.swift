//
//  Repository.swift
//  DependencyInjectionSample
//
//  Created by Yoshitaka Seki on 2018/03/25.
//  Copyright © 2018年 takasek. All rights reserved.
//

import Foundation

protocol DateRepositoryProtocol {
    func fetchLastDate() -> Date?
    mutating func saveCurrentDate(_ now: Date)
}

final class DateRepositoryImpl: DateRepositoryProtocol {
    func fetchLastDate() -> Date? {
        let lastTimeIntervalSince1970 = UserDefaults.standard.double(forKey: "lastTimeIntervalSince1970")
        if lastTimeIntervalSince1970 != 0 {
            return Date(timeIntervalSince1970: lastTimeIntervalSince1970)
        } else {
            return nil
        }
    }
    func saveCurrentDate(_ now: Date) {
        UserDefaults.standard.set(now.timeIntervalSince1970, forKey: "lastTimeIntervalSince1970")
    }
}

struct MockDateRepositoryImpl: DateRepositoryProtocol {
    private(set) var lastDate: Date?

    init(lastDate: Date?) {
        self.lastDate = lastDate
    }

    func fetchLastDate() -> Date? {
        return lastDate
    }
    mutating func saveCurrentDate(_ now: Date) {
        lastDate = now
    }
}
