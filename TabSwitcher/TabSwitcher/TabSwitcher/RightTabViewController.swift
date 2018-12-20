//
//  RightTabViewController.swift
//  TabSwitcher
//
//  Created by Raluca Mesterca on 19/12/2018.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

protocol RightTabBarDelegate: class {
    func didPressRightTab()
}

class RightTabViewController: UIViewController, Storyboardable {
    
    static var storyboardName: String = StoryboardName.TabSwitcher.rawValue
    static var storyboardIdentifier: String = StoryboardId.RightTabViewController.rawValue

    @IBOutlet weak var rightTabView: TabView!

    weak var delegate: RightTabBarDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func pressedRightTabButton(_ sender: Any) {
        delegate.didPressRightTab()
    }



}
