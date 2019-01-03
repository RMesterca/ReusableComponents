//
//  TabSwitchAnimator.swift
//  TabSwitcher
//
//  Created by Raluca Mesterca on 03/01/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation
import UIKit

class TabSwitchAnimator {

    private var behindTabAlpha: CGFloat = 0.5
    private var frontTabAlpha: CGFloat = 1
    private var animateDuration: TimeInterval = 2


    func getAnimationForTab(view: TabView, angle: CGFloat, zPosition: [CGFloat], xPosition: CGFloat, alpha: [CGFloat]) {
        let animation = createGroupAnimation(angle: angle, zPosition: zPosition, xPosition: xPosition, alpha: alpha)
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        view.layer.add(animation, forKey: "viewAnimation")
    }

    fileprivate func createGroupAnimation(angle: CGFloat, zPosition: [CGFloat], xPosition: CGFloat, alpha: [CGFloat]) -> CAAnimationGroup {
        let translateAnimation = createTranslateAnimation(xPosition: xPosition)
        let transformAnimation = createRotationAnimation(angle: angle)
        let positionAnimation = createPositionAnimation(zPosition: zPosition)
        let opacityAnimation = createOpacityAnimation(alpha: alpha)

        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [translateAnimation,
                                     transformAnimation,
                                     positionAnimation,
                                     opacityAnimation]
        groupAnimation.duration = animateDuration

        return groupAnimation
    }

    fileprivate func createTranslateAnimation(xPosition: CGFloat) -> CAKeyframeAnimation {
        let translateAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        translateAnimation.values = [0, xPosition, 0]
        translateAnimation.keyTimes = [0, 0.2, 1]
        return translateAnimation
    }

    fileprivate func createPositionAnimation(zPosition: [CGFloat]) -> CAKeyframeAnimation {
        let positionAnimation = CAKeyframeAnimation(keyPath: "transform.translation.z")
        positionAnimation.values = zPosition
        positionAnimation.duration = animateDuration
        positionAnimation.keyTimes = [0, 0.5, 1]
        return positionAnimation
    }

    fileprivate func createRotationAnimation(angle: CGFloat) -> CAKeyframeAnimation {
        let transformAnimation = CAKeyframeAnimation(keyPath: "transform.rotation")
        transformAnimation.values = [0, angle, 0]
        transformAnimation.keyTimes = [0.2, 0.5, 1]

        return transformAnimation
    }

    fileprivate func createOpacityAnimation(alpha: [CGFloat]) -> CAKeyframeAnimation {
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.values = alpha
        opacityAnimation.keyTimes = [0, 0.5]
        return opacityAnimation

    }
}
