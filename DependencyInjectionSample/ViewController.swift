//
//  ViewController.swift
//  DependencyInjectionSample
//
//  Created by Yoshitaka Seki on 2018/03/25.
//  Copyright © 2018年 takasek. All rights reserved.
//

import UIKit
import DIKit

final class ViewController: UIViewController, PresenterDelegate, FactoryMethodInjectable {
    struct Dependency {
        let presenter: Presenter
    }
    static func makeInstance(dependency: Dependency) -> ViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! ViewController
        vc.presenter = dependency.presenter
        return vc
    }

    @IBOutlet weak var label: UILabel!

    var presenter: Presenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.delegate = self

        presenter.load()
    }

    func presenterDidReceiveItem(_ presenter: Presenter) {
        label.text = presenter.timeDescription
    }
}
