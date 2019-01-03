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

    fileprivate func toggleUserInteraction() {
        leftTabView.isUserInteractionEnabled.toggle()
        rightTabView.isUserInteractionEnabled.toggle()
    }

    fileprivate func scissorTabAnimation(tabViews: [TabView]) {

        var angles: [CGFloat?] = []
        tabViews.forEach { (view) in
            let angle = view.isLeftTabView ? CGFloat.pi/8 : CGFloat.pi/(-8)
            angles.append(angle)
        }

        getAnimationForTab(view: tabViews[0], angle:  angles[0] ?? 0, zPosition: [50, 100], xPosition: 200, alpha: [behindTabAlpha, frontTabAlpha])
        getAnimationForTab(view: tabViews[1], angle: angles[1] ?? 0, zPosition: [100, 50], xPosition: -200, alpha: [frontTabAlpha, behindTabAlpha])
    }

    func createGroupAnimation(angle: CGFloat, zPosition: [CGFloat], xPosition: CGFloat, alpha: [CGFloat]) -> CAAnimationGroup {
        let translateAnimation = createTranslateAnimation(xPosition: xPosition)
        let transformAnimation = createRotationAnimation(angle: angle)
        let positionAnimation = createPositionAnimation(zPosition: zPosition)
        let opacityAnimation = createOpacityAnimation(alpha: alpha)

        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [translateAnimation, transformAnimation, positionAnimation, opacityAnimation]
        groupAnimation.duration = animateDuration

        return groupAnimation
    }

    func createTranslateAnimation(xPosition: CGFloat) -> CAKeyframeAnimation {
        let translateAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        translateAnimation.values = [0, xPosition, 0]
        translateAnimation.keyTimes = [0, 0.2, 1]
        return translateAnimation
    }

    func createPositionAnimation(zPosition: [CGFloat]) -> CAKeyframeAnimation {
        let positionAnimation = CAKeyframeAnimation(keyPath: "transform.translation.z")
        positionAnimation.values = zPosition
        positionAnimation.duration = animateDuration
        positionAnimation.keyTimes = [0, 0.5, 1]
        return positionAnimation
    }

    func createRotationAnimation(angle: CGFloat) -> CAKeyframeAnimation {
        let transformAnimation = CAKeyframeAnimation(keyPath: "transform.rotation")
        transformAnimation.values = [0, angle, 0]
        transformAnimation.keyTimes = [0.2, 0.5, 1]

        return transformAnimation
    }

    func createOpacityAnimation(alpha: [CGFloat]) -> CAKeyframeAnimation {
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.values = alpha
        opacityAnimation.keyTimes = [0, 0.5]
        return opacityAnimation

    }

    func getAnimationForTab(view: TabView, angle: CGFloat, zPosition: [CGFloat], xPosition: CGFloat, alpha: [CGFloat]) {
        let animation = createGroupAnimation(angle: angle, zPosition: zPosition, xPosition: xPosition, alpha: alpha)
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        view.layer.add(animation, forKey: "viewAnimation")
    }
}

