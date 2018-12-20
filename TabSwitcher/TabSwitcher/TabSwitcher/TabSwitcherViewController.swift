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

    //MARK: Properties
    private var behindTabAlpha: CGFloat = 0.5
    private var frontTabAlpha: CGFloat = 1

    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        leftTabView.isUserInteractionEnabled = false
        rightTabView.isUserInteractionEnabled = true
    }

    //MARK: Actions
    @IBAction func didPressLeftTab(_ sender: Any) {
        updateTabViews(frontTab: leftTabView, behindTab: rightTabView,
                       behindTabAlpha: self.behindTabAlpha, frontTabAlpha: self.frontTabAlpha)
    }

    @IBAction func didPressRightTab(_ sender: Any) {
        updateTabViews(frontTab: rightTabView, behindTab: leftTabView,
                       behindTabAlpha: self.behindTabAlpha, frontTabAlpha: self.frontTabAlpha)
    }
}

//MARK: Container View Helper Methods
extension TabSwitcherViewController {

    fileprivate func switchTabs(frontTab: UIView, behindTab: UIView) {
        self.view.bringSubviewToFront(frontTab)
//        self.view.sendSubviewToBack(behindTab)
    }


    fileprivate func updateTabViews(frontTab: UIView, behindTab: UIView,
                                    behindTabAlpha: CGFloat, frontTabAlpha: CGFloat) {
        switchTabs(frontTab: frontTab, behindTab: behindTab)
        toggleUserInteraction(frontTab: frontTab, behindTab: behindTab)
        setViewAlpha(tabViews: [frontTab, behindTab], behindTabAlpha: behindTabAlpha , frontTabAlpha: frontTabAlpha)
    }


    fileprivate func toggleUserInteraction(frontTab: UIView, behindTab: UIView) {
        frontTab.isUserInteractionEnabled = false
        behindTab.isUserInteractionEnabled = true
    }

    fileprivate func setViewAlpha(tabViews: [UIView], behindTabAlpha: CGFloat, frontTabAlpha: CGFloat) {
        tabViews.forEach { view in
            let alpha: CGFloat = view.isUserInteractionEnabled ? behindTabAlpha : frontTabAlpha
            view.alpha = alpha
        }
    }
}

