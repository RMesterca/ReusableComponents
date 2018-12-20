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
    @IBOutlet weak var container: UIView!

    //MARK: Properties
    private lazy var leftTabVC: LeftTabViewController = {
        let viewController = LeftTabViewController.instantiate()
        self.addChild(viewController)
        return viewController
    }()

    private lazy var rightTabVC: RightTabViewController = {
        let viewController = RightTabViewController.instantiate()
        self.addChild(viewController)
        return viewController
    }()

    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rightTabVC.delegate = self
        leftTabVC.delegate = self

        add(childVC: rightTabVC)
        add(childVC: leftTabVC)
    }
}

//MARK: LeftTabVC Delegate
extension TabSwitcherViewController: LeftTabBarDelegate {

    func didPressLeftTab() {
        didPressTab(frontVC: leftTabVC, behindVC: rightTabVC, frontVCAlpha: 1, behindVCAlpha: 0.6)
    }
}

//MARK: RightTabVC Delegate
extension TabSwitcherViewController: RightTabBarDelegate {

    func didPressRightTab() {
        didPressTab(frontVC: rightTabVC, behindVC: leftTabVC, frontVCAlpha: 1, behindVCAlpha: 0.6)
    }
}

//MARK: Container View Helper Methods
extension TabSwitcherViewController {

    fileprivate func add(childVC: UIViewController) {
        self.addChild(childVC)

        childVC.view.frame = CGRect(
            x: 0,
            y: 0,
            width: self.container.frame.size.width,
            height: self.container.frame.size.height)

        self.container.addSubview(childVC.view)
        childVC.didMove(toParent: self)
    }

    fileprivate func updateView(frontVC: UIViewController, behindVC: UIViewController,
                                frontVCAlpha: CGFloat, behindVCAlpha: CGFloat) {
        self.add(childVC: behindVC)
        self.add(childVC: frontVC)
        setViewAlpha(vc: [behindVC, frontVC], behindVCAlpha: behindVCAlpha, frontVCAlpha: frontVCAlpha)
    }

    fileprivate func didPressTab(frontVC: UIViewController, behindVC: UIViewController,
                                 frontVCAlpha: CGFloat, behindVCAlpha: CGFloat) {
        removeChildren(vc: [frontVC, behindVC])
        toggleUserInteraction(frontVC: frontVC, behindVC: behindVC)
        updateView(frontVC: frontVC, behindVC: behindVC,
                   frontVCAlpha: frontVCAlpha, behindVCAlpha: behindVCAlpha)

    }

    fileprivate func removeChildren(vc: [UIViewController]) {
        vc.forEach { (v) in
            v.removeFromParent()
        }
    }

    fileprivate func toggleUserInteraction(frontVC: UIViewController, behindVC: UIViewController) {
        frontVC.view.isUserInteractionEnabled = false
        behindVC.view.isUserInteractionEnabled = true
    }

    fileprivate func setViewAlpha(vc: [UIViewController], behindVCAlpha: CGFloat, frontVCAlpha: CGFloat) {
        vc.forEach { v in
            let alpha: CGFloat = v.view.isUserInteractionEnabled ? behindVCAlpha : frontVCAlpha
            v.view.alpha = alpha
        }
    }
}

