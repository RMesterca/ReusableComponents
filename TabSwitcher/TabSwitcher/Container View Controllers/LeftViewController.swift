//
//  LeftViewController.swift
//  TabSwitcher
//
//  Created by Raluca Mesterca on 03/01/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController, Storyboardable {
    static var storyboardName: String = "LeftViewController"
    static var storyboardIdentifier: String = StoryboardName.LeftVC.rawValue

    @IBAction func middleLeftButton(_ sender: Any) {
        print("middle left")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }


}
