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
    private lazy var animator = UIViewPropertyAnimator(duration: 5, curve: .easeInOut)

    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        leftTabView.alpha = frontTabAlpha
        rightTabView.alpha = behindTabAlpha
    }

    //MARK: Actions
    @IBAction func didPressLeftTab(_ sender: Any) {
        print("left")
        scissorTabAnimation(tabViews: [leftTabView, rightTabView])
    }

    @IBAction func didPressRightTab(_ sender: Any) {
        print("right")
        scissorTabAnimation(tabViews: [rightTabView, leftTabView])
    }
}

//MARK: Container View Helper Methods
extension TabSwitcherViewController {

    fileprivate func toggleUserInteraction() {
        leftTabView.isUserInteractionEnabled.toggle()
        rightTabView.isUserInteractionEnabled.toggle()
    }

    fileprivate func scissorTabAnimation(tabViews: [TabView]) { //, onCompletion: (() -> ())?) {

//        animator.isUserInteractionEnabled = false

            UIView.animateKeyframes(withDuration: self.animator.duration, delay: 0, animations: {

                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {

                    tabViews.forEach({ (view) in
                        let angle = view.isLeftTabView ? CGFloat.pi/(-4) : CGFloat.pi/4
                        view.transform = CGAffineTransform(rotationAngle: angle)
                    })

//                    self.switchTabsPosition(frontTab: tabViews[0], behindTab: tabViews[1])
                    self.switchTabsAlpha(frontTab: tabViews[0], behindTab: tabViews[1])
                })

                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.2, animations: {
                    self.switchTabsPosition(frontTab: tabViews[0], behindTab: tabViews[1])
//                    tabViews[0].layer.zPosition = 100
//                    tabViews[1].layer.zPosition = 50
//                    self.view.layoutSubviews()





                })

                UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.2, animations: {
                    tabViews[0].alpha = self.frontTabAlpha
                    tabViews[1].alpha = self.behindTabAlpha
//                    self.switchTabsAlpha(frontTab: tabViews[0], behindTab: tabViews[1])

                })

                UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.3, animations: {
                    tabViews.forEach({ (view) in
                        view.transform = .identity
                    })
                })
            })
    }


    fileprivate func switchTabsPosition(frontTab: UIView, behindTab: UIView) {
//        self.view.bringSubviewToFront(frontTab)
//

//        self.view.layoutSubviews()

        UIView.transition(with: self.view, duration: 10, options: .transitionCrossDissolve, animations: {
            frontTab.layer.zPosition = 100
            behindTab.layer.zPosition = 50
        }, completion: nil)
    }

    fileprivate func switchTabsAlpha(frontTab: UIView, behindTab: UIView) {
        frontTab.alpha = frontTabAlpha
        behindTab.alpha = behindTabAlpha
    }
}

