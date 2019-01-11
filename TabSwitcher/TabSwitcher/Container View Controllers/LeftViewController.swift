//
//  LeftViewController.swift
//  TabSwitcher
//
//  Created by Raluca Mesterca on 03/01/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController, Storyboardable, TabNaming { 
    static var storyboardName: String = StoryboardName.LeftVC.rawValue
    static var storyboardIdentifier: String = "LeftViewController"

    var titleUpdate: ((String) -> Void)? 

    @IBAction func middleLeftButton(_ sender: Any) {
        print("middle left")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let title = "Messages1"
        titleUpdate?(title)
    }
}
