//
//  ViewController.swift
//  DependencyInjectionSample
//
//  Created by Yoshitaka Seki on 2018/03/25.
//  Copyright © 2018年 takasek. All rights reserved.
//

import UIKit

final class ViewController: UIViewController, PresenterDelegate {
    @IBOutlet weak var label: UILabel!

    let presenter = Presenter()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.delegate = self

        presenter.load()
    }

    func presenterDidReceiveItem(_ presenter: Presenter) {
        label.text = presenter.timeDescription
    }
}
