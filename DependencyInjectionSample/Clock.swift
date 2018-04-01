//
//  Clock.swift
//  DependencyInjectionSample
//
//  Created by Yoshitaka Seki on 2018/03/30.
//  Copyright © 2018年 takasek. All rights reserved.
//

import Foundation

protocol Clock {
    var now: Date { get }
}
struct SystemClock: Clock {
    var now: Date { return Date() }
}
struct MockClock: Clock {
    let now: Date
}
