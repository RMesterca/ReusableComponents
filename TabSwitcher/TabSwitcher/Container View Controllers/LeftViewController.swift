//
//  LeftViewController.swift
//  TabSwitcher
//
//  Created by Raluca Mesterca on 03/01/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController, Storyboardable {
    static var storyboardName: String = StoryboardName.LeftVC.rawValue
    static var storyboardIdentifier: String = "LeftViewController"

    @IBAction func middleLeftButton(_ sender: Any) {
        print("middle left")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension LeftViewController: TabNaming {
    func titleForLabel(_ completion: (String) -> Void) {
    }
}
