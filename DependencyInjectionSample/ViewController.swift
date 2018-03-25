//
//  ViewController.swift
//  DependencyInjectionSample
//
//  Created by Yoshitaka Seki on 2018/03/25.
//  Copyright © 2018年 takasek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        let lastDate: Date?
        let lastTimeIntervalSince1970 = UserDefaults.standard.double(forKey: "lastTimeIntervalSince1970")
        if lastTimeIntervalSince1970 != 0 {
            lastDate = Date(timeIntervalSince1970: lastTimeIntervalSince1970)
        } else {
            lastDate = nil
        }
        let now = Date()

        label.text = timeDescription(from: lastDate, to: now)

        UserDefaults.standard.set(now.timeIntervalSince1970, forKey: "lastTimeIntervalSince1970")
    }

    func timeDescription(from lastDate: Date?, to now: Date) -> String {
        let f = DateFormatter()
        f.setLocalizedDateFormatFromTemplate("kHms")

        return String(
            format: "last: %@\nnow: %@",
            lastDate.flatMap(f.string(from:)) ?? "--",
            f.string(from: now)
        )
    }
}

