//
//  PresenterTests.swift
//  DependencyInjectionSampleTests
//
//  Created by Yoshitaka Seki on 2018/03/25.
//  Copyright © 2018年 takasek. All rights reserved.
//

import XCTest
@testable import DependencyInjectionSample

import Swinject
import SwinjectStoryboard

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

    // ⚠️以下のテストコードは、よくないテストの設計です！⚠️
    // 本来はそもそもテストで依存グラフの解決をすべきではない。テスタブルにしたいのであれば、UseCaseを抽象化（protocolとして定義）し、MockUseCaseを渡すべき。
    // 本プロジェクトの目的はDI frameworkの試用・比較であるため、その点ご容赦のうえご覧下さい。

    func test_Presenterのloadが正しく行われる() {
        let repository = MockDateRepositoryImpl(
            lastDate: nil
        )
        let useCase = UseCase(dependency: .init(
            dateRepository: repository,
            clock: MockClock(now: 📅)
            ))
        let presenter = Presenter(dependency: .init(
            useCase: useCase
            ))

        XCTAssertNil(presenter.timeDescription)

        presenter.load()

        XCTAssertEqual(presenter.timeDescription, "last: --\nnow: 2:03:04")
    }

    func test_Presenterのloadが正しく行われる_Swinject版() {
        let clock = MockClock(now: 📅)
        let presenter = testContainer.resolve(Presenter.self, argument: clock as Clock)!

        XCTAssertNil(presenter.timeDescription)

        presenter.load()

        XCTAssertEqual(presenter.timeDescription, "last: --\nnow: 2:03:04")
    }

    func test_Presenterのloadが正しく行われる_MinimumCakePatternと似て非なるもの版() {
        let clock = MockClock(now: 📅)
        let presenter = MockPresenterService(clock: clock).presenter

        XCTAssertNil(presenter.timeDescription)

        presenter.load()

        XCTAssertEqual(presenter.timeDescription, "last: --\nnow: 2:03:04")
    }

    func test_Presenterのloadが正しく行われる_DIKit版() {
        let clock = MockClock(now: 📅)
        let presenter = testResolver.resolvePresenter(clock: clock)

        XCTAssertNil(presenter.timeDescription)

        presenter.load()

        XCTAssertEqual(presenter.timeDescription, "last: --\nnow: 2:03:04")
    }

}
