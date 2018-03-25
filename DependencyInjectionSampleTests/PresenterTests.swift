//
//  PresenterTests.swift
//  DependencyInjectionSampleTests
//
//  Created by Yoshitaka Seki on 2018/03/25.
//  Copyright © 2018年 takasek. All rights reserved.
//

import XCTest
@testable import DependencyInjectionSample

class PresenterTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    let 📅 = DateComponents(
        calendar: Calendar(identifier: .gregorian),
        timeZone: TimeZone.current,
        year: 1999, month: 7, day: 1, hour: 2, minute: 3, second: 4
        ).date!

    func test_Presenterのloadが正しく行われる() {
        let repository = MockDateRepositoryImpl(
            lastDate: nil
        )
        let useCase = UseCase(dependency: .init(
            dateRepository: repository,
            now: 📅
            ))
        let presenter = Presenter(dependency: .init(
            useCase: useCase
            ))

        XCTAssertNil(presenter.timeDescription)

        presenter.load()

        XCTAssertEqual(presenter.timeDescription, "last: --\nnow: 2:03:04")
    }
}
