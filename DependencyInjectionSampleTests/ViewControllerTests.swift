//
//  ViewControllerTests.swift
//  DependencyInjectionSampleTests
//
//  Created by Yoshitaka Seki on 2018/03/25.
//  Copyright © 2018年 takasek. All rights reserved.
//

import XCTest
@testable import DependencyInjectionSample

import Swinject
import SwinjectStoryboard

class ViewControllerTests: XCTestCase {
    
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
    // 本来はそもそもテストで依存グラフの解決をすべきではない。テスタブルにしたいのであれば、presenterを抽象化（protocolとして定義）し、MockPresenterを渡すべき。
    // 本プロジェクトの目的はDI frameworkの試用・比較であるため、その点ご容赦のうえご覧下さい。

    func test_ViewControllerの初回表示時にlastが空でnowが現時刻() {
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
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! ViewController
        vc.presenter = presenter

        let window = UIWindow()
        window.rootViewController = vc
        window.makeKeyAndVisible()

        XCTAssertEqual(vc.label.text, "last: --\nnow: 2:03:04")
    }

    func test_ViewControllerの初回表示時にlastが空でnowが現時刻_Swinject版() {
        let clock = MockClock(now: 📅)
        let vc = testContainer.resolve(ViewController.self, argument: clock as Clock)!

        let window = UIWindow()
        window.rootViewController = vc
        window.makeKeyAndVisible()

        XCTAssertEqual(vc.label.text, "last: --\nnow: 2:03:04")
    }

    func test_ViewControllerの初回表示時にlastが空でnowが現時刻_MinimalCakePatternと似て非なるもの版() {
        let clock = MockClock(now: 📅)
        let vc = MockViewControllerService(clock: clock).viewController

        let window = UIWindow()
        window.rootViewController = vc
        window.makeKeyAndVisible()

        XCTAssertEqual(vc.label.text, "last: --\nnow: 2:03:04")
    }

    func test_ViewControllerの初回表示時にlastが空でnowが現時刻_DIKit版() {
        let clock = MockClock(now: 📅)
        let vc = testResolver.resolveViewController(clock: clock)

        let window = UIWindow()
        window.rootViewController = vc
        window.makeKeyAndVisible()

        XCTAssertEqual(vc.label.text, "last: --\nnow: 2:03:04")
    }

}
