//
//  ViewControllerTests.swift
//  DependencyInjectionSampleTests
//
//  Created by Yoshitaka Seki on 2018/03/25.
//  Copyright © 2018年 takasek. All rights reserved.
//

import XCTest
@testable import DependencyInjectionSample

class ViewControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_ViewControllerの初回表示時にlastが空でnowが現時刻() {
        let window = UIWindow()
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! ViewController
        window.rootViewController = vc
        window.makeKeyAndVisible()

        XCTAssertEqual(vc.label.text, "last: --\nnow: x:xx:xx")
    }
}
