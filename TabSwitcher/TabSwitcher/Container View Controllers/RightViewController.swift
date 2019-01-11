//
//  RightViewController.swift
//  TabSwitcher
//
//  Created by Raluca Mesterca on 03/01/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class RightViewController: UIViewController, Storyboardable, TabNaming {
    static var storyboardName: String = StoryboardName.RightVC.rawValue
    static var storyboardIdentifier: String = "RightViewController"

    var titleUpdate: ((String) -> Void)? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let title = "Messages2"
        titleUpdate?(title)
    }

    @IBAction func middleRightButton(_ sender: Any) {
        print("middle right")
    }
}
