//
//  LeftTabViewController.swift
//  TabSwitcher
//
//  Created by Raluca Mesterca on 19/12/2018.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

protocol LeftTabBarDelegate: class {
    func didPressLeftTab()
}

class LeftTabViewController: UIViewController, Storyboardable {
    
    static var storyboardName: String = StoryboardName.TabSwitcher.rawValue
    static var storyboardIdentifier: String = StoryboardId.LeftTabViewController.rawValue

    @IBOutlet weak var leftTabView: TabView!

    weak var delegate: LeftTabBarDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isUserInteractionEnabled = false
    }

    @IBAction func pressedLeftTabButton(_ sender: Any) {
        delegate.didPressLeftTab()
    }



}
