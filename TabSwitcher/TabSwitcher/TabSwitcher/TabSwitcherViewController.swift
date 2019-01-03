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
    private var animateDuration: TimeInterval = 2
    
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
    
    fileprivate func scissorTabAnimation(tabViews: [TabView]) {
        
        var angles: [CGFloat?] = []
        tabViews.forEach { (view) in
            let angle = view.isLeftTabView ? CGFloat.pi/8 : CGFloat.pi/(-8)
            angles.append(angle)
        }
        
        let tabSwitchAnimator = TabSwitchAnimator()
        
        tabSwitchAnimator.getAnimationForTab(view: tabViews[0],
                                             angle:  angles[0] ?? 0,
                                             zPosition: [50, 100],
                                             xPosition: 200,
                                             alpha: [behindTabAlpha, frontTabAlpha])
        
        tabSwitchAnimator.getAnimationForTab(view: tabViews[1],
                                             angle: angles[1] ?? 0,
                                             zPosition: [100, 50],
                                             xPosition: -200,
                                             alpha: [frontTabAlpha, behindTabAlpha])
    }
}
