//
//  TabSwitcherViewController.swift
//  TabSwitcher
//
//  Created by Raluca Mesterca on 19/12/2018.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

class TabSwitcherViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var leftTabView: TabView!
    @IBOutlet weak var rightTabView: TabView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet var tabViewBottomContraints: [NSLayoutConstraint]!

    //MARK: Properties
    private var behindTabAlpha: CGFloat = 0.5
    private var frontTabAlpha: CGFloat = 1

    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: Actions
    @IBAction func didPressLeftTab(_ sender: Any) {
        print("left")
        switchTabs(frontTab: leftTabView, behindTab: rightTabView)
    }

    @IBAction func didPressRightTab(_ sender: Any) {
        print("right")
        switchTabs(frontTab: rightTabView, behindTab: leftTabView)
    }
}

//MARK: Container View Helper Methods
extension TabSwitcherViewController {

    fileprivate func checkForTabBar() {
        

    }

    fileprivate func switchTabs(frontTab: UIView, behindTab: UIView) {
        self.view.bringSubviewToFront(frontTab)
        frontTab.alpha = frontTabAlpha
        behindTab.alpha = behindTabAlpha
    }
}

