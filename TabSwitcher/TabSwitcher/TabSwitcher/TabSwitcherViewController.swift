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
        
        setupInitialTabState()
    }

    //MARK: Actions
    @IBAction func didPressLeftTab(_ sender: Any) {
        print("left")
        toggleActiveButtons()
        scissorTabAnimation(tabToFront: leftTabView, tabToBack: rightTabView)
    }

    @IBAction func didPressRightTab(_ sender: Any) {
        print("right")
        toggleActiveButtons()
        scissorTabAnimation(tabToFront: rightTabView, tabToBack: leftTabView)
    }
}

//MARK: Methods
extension TabSwitcherViewController {

    fileprivate func setupInitialTabState() {
        leftTabView.alpha = frontTabAlpha
        rightTabView.alpha = behindTabAlpha

        leftButton.isUserInteractionEnabled = false
        rightButton.isUserInteractionEnabled = true
    }

    fileprivate func toggleActiveButtons() {
        leftButton.isUserInteractionEnabled.toggle()
        rightButton.isUserInteractionEnabled.toggle()
    }
}

//MARK: Tab Switch Animation Methods
extension TabSwitcherViewController {

    fileprivate func scissorTabAnimation(tabToFront: TabView, tabToBack: TabView) {

        let zPosition: [CGFloat] = [50, 100]

        let xyPositionFront = tabToFront.isLeftTabView ? CGPoint(x: -200, y: -20) : CGPoint(x: 200, y: -20)
        let xyPositionBack = tabToBack.isLeftTabView ? CGPoint(x: -200, y: -20) : CGPoint(x: 200, y: -20)

        let alpha = (behindTabAlpha, frontTabAlpha)
        let alphaReversed = (frontTabAlpha, behindTabAlpha)

        let frontAngle = tabToFront.isLeftTabView ? CGFloat.pi/8 : CGFloat.pi/(-8)
        let behindAngle = tabToBack.isLeftTabView ? CGFloat.pi/8 : CGFloat.pi/(-8)

        switchTabs(tabToFront, tabToBack)

        let tabSwitchAnimator = TabSwitchAnimator()

        let frontAnimation = tabSwitchAnimator.getAnimationForTab(
            angle: frontAngle,
            zPosition: zPosition,
            xyPosition: xyPositionFront,
            alphas: alpha)

        let behindAnimation = tabSwitchAnimator.getAnimationForTab(
            angle: behindAngle,
            zPosition: zPosition.reversed(),
            xyPosition: xyPositionBack,
            alphas: alphaReversed)

        frontAnimation.delegate = self
        behindAnimation.delegate = self

        tabToFront.layer.add(frontAnimation, forKey: "viewAnimation")
        tabToBack.layer.add(behindAnimation, forKey: "viewAnimation")
    }

    fileprivate func switchTabs(_ tabToFront: TabView, _ tabToBack: TabView) {
        self.view.bringSubviewToFront(tabToFront)

        tabToFront.alpha = frontTabAlpha
        tabToBack.alpha = behindTabAlpha
    }
}

//MARK: Tab Switch Animation Delegate
extension TabSwitcherViewController: CAAnimationDelegate {
    func animationDidStart(_ anim: CAAnimation) {
        leftTabView.isUserInteractionEnabled = false
        rightTabView.isUserInteractionEnabled = false
    }

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        leftTabView.isUserInteractionEnabled = flag
        rightTabView.isUserInteractionEnabled = flag
    }
}
