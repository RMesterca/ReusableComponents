//
//  RightViewController.swift
//  TabSwitcher
//
//  Created by Raluca Mesterca on 03/01/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class RightViewController: UIViewController, Storyboardable {
    static var storyboardName: String = "RightViewController"
    static var storyboardIdentifier: String = StoryboardName.RightVC.rawValue

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func middleRightButton(_ sender: Any) {
        print("middle right")
    }
}
