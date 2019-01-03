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
    
    @IBAction func middleRightButton(_ sender: Any) {
        print("middle right")

    }
    //MARK: Actions
    @IBAction func didPressLeftTab(_ sender: Any) {
        print("left")
        toggleActiveButtons()
        scissorTabAnimation(frontTab: leftTabView, behindTab: rightTabView)
    }

    @IBAction func middleLeftButton(_ sender: Any) {
        print("middle left")
    }
    @IBAction func didPressRightTab(_ sender: Any) {
        print("right")
        toggleActiveButtons()
        scissorTabAnimation(frontTab: rightTabView, behindTab: leftTabView)
    }

    //MARK: Methods
    fileprivate func toggleActiveButtons() {
        leftButton.isUserInteractionEnabled.toggle()
        rightButton.isUserInteractionEnabled.toggle()
    }

    fileprivate func setupInitialTabState() {
        leftTabView.alpha = frontTabAlpha
        rightTabView.alpha = behindTabAlpha

        leftButton.isUserInteractionEnabled = false
        rightButton.isUserInteractionEnabled = true
    }
}

//MARK: Container View Helper Methods
extension TabSwitcherViewController {
    
    fileprivate func scissorTabAnimation(frontTab: TabView, behindTab: TabView) {

        let tabSwitchAnimator = TabSwitchAnimator()
        let zPosition: [CGFloat] = [50, 100]
        let xyPosition = CGPoint(x: 200, y: -20)
        let xyPositionReversed = CGPoint(x: -200, y: -20)

        let alpha = (behindTabAlpha, frontTabAlpha)
        let alphaReversed = (frontTabAlpha, behindTabAlpha)

        let frontAngle = frontTab.isLeftTabView ? CGFloat.pi/8 : CGFloat.pi/(-8)
        let behindAngle = behindTab.isLeftTabView ? CGFloat.pi/8 : CGFloat.pi/(-8)

        self.view.bringSubviewToFront(frontTab)

        frontTab.alpha = frontTabAlpha
        behindTab.alpha = behindTabAlpha

        tabSwitchAnimator.getAnimationForTab(view: frontTab,
                                             angle: frontAngle,
                                             zPosition: zPosition,
                                             xyPosition: xyPosition,
                                             alphas: alpha)
        
        tabSwitchAnimator.getAnimationForTab(view: behindTab,
                                             angle: behindAngle,
                                             zPosition: zPosition.reversed(),
                                             xyPosition: xyPositionReversed,
                                             alphas: alphaReversed)
    }
}
