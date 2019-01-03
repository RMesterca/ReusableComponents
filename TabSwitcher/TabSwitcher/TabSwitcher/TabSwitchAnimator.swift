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

    private var animateDuration: TimeInterval = 0.4
    
    func getAnimationForTab(
        view: TabView,
        angle: CGFloat,
        zPosition: [CGFloat],
        xyPosition: CGPoint,
        alphas: (CGFloat, CGFloat)) -> CAAnimation {

        let animation = createGroupAnimation(
            angle: angle,
            zPosition: zPosition,
            xyPosition: xyPosition,
            alphas: alphas)

        animation.fillMode = CAMediaTimingFillMode.removed
        animation.isRemovedOnCompletion = true

        return animation
    }
}

extension TabSwitchAnimator {

    fileprivate func createGroupAnimation(
        angle: CGFloat,
        zPosition: [CGFloat],
        xyPosition: CGPoint,
        alphas: (CGFloat, CGFloat)) -> CAAnimationGroup {

        let horizontalTranslateAnimation = createHorizontalTranslateAnimation(xPosition: xyPosition)
        let verticalTranslateAnimation = createVerticalTranslateAnimation(yPosition: xyPosition)
        let rotationAnimation = createRotationAnimation(angle: angle)
        let positionAnimation = createPositionAnimation(zPosition: zPosition)
        let opacityAnimation = createOpacityAnimation(alphas: alphas)

        let groupAnimation = CAAnimationGroup()
        
        groupAnimation.duration = animateDuration
        groupAnimation.animations = [horizontalTranslateAnimation,
                                     verticalTranslateAnimation,
                                     rotationAnimation,
                                     positionAnimation,
                                     opacityAnimation]

        return groupAnimation
    }

    fileprivate func createHorizontalTranslateAnimation(xPosition: CGPoint) -> CAKeyframeAnimation {
        let translateAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        translateAnimation.values = [0, xPosition.x, 0]
        translateAnimation.keyTimes = [0, 0.5, 1]
        translateAnimation.timingFunctions = [
            CAMediaTimingFunction(name: .easeOut),
            CAMediaTimingFunction(name: .easeInEaseOut)
        ]

        return translateAnimation
    }

    fileprivate func createVerticalTranslateAnimation(yPosition: CGPoint) -> CAKeyframeAnimation {
        let translateAnimation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        translateAnimation.values = [0, yPosition.y, 0]
        translateAnimation.keyTimes = [0, 0.7, 1]
        translateAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)

        return translateAnimation
    }

    fileprivate func createPositionAnimation(zPosition: [CGFloat]) -> CAKeyframeAnimation {
        let positionAnimation = CAKeyframeAnimation(keyPath: "transform.translation.z")
        positionAnimation.values = zPosition
        positionAnimation.duration = animateDuration
        positionAnimation.keyTimes = [0, 0.7, 1]

        return positionAnimation
    }

    fileprivate func createRotationAnimation(angle: CGFloat) -> CAKeyframeAnimation {
        let rotationAnimation = CAKeyframeAnimation(keyPath: "transform.rotation")
        rotationAnimation.values = [0, angle, 0]
        rotationAnimation.keyTimes = [0.01, 0.7, 1]
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)

        return rotationAnimation
    }

    fileprivate func createOpacityAnimation(alphas: (CGFloat, CGFloat)) -> CAKeyframeAnimation {
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.values = [alphas.0, alphas.1]
        opacityAnimation.keyTimes = [0, 0.7]
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        return opacityAnimation
    }
}
