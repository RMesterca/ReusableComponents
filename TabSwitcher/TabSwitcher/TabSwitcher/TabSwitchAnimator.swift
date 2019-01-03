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

    private var animateDuration: TimeInterval = 1
    
    func getAnimationForTab(
        view: TabView,
        angle: CGFloat,
        zPosition: [CGFloat],
        xyPosition: CGPoint,
        alphas: (CGFloat, CGFloat)) {

        if view.isLeftTabView {
//            view.getRotationPoint(rotationPoint: CGPoint(x: 0, y: 0))
//            view.setAnchorPoint(CGPoint(x: 0, y: 0))
        } else {
//            view.getRotationPoint(rotationPoint: CGPoint(x: view.bounds.width, y: 0))
//            view.setAnchorPoint(CGPoint(x: 1, y: 0))
        }

        let animation = createGroupAnimation(angle: angle, zPosition: zPosition, xyPosition: xyPosition, alphas: alphas)
        animation.fillMode = CAMediaTimingFillMode.removed
        animation.isRemovedOnCompletion = true

        view.layer.add(animation, forKey: "viewAnimation")
    }
}

extension TabSwitchAnimator {

    fileprivate func createGroupAnimation(angle: CGFloat, zPosition: [CGFloat], xyPosition: CGPoint, alphas: (CGFloat, CGFloat)) -> CAAnimationGroup {
        let hTranslateAnimation = createHorizontalTranslateAnimation(xPosition: xyPosition)
        let vTranslateAnimation = createVerticalTranslateAnimation(yPosition: xyPosition)


        let rotationAnimation = createRotationAnimation(angle: angle)
        let positionAnimation = createPositionAnimation(zPosition: zPosition)
        let opacityAnimation = createOpacityAnimation(alphas: alphas)

        let groupAnimation = CAAnimationGroup()
        
        groupAnimation.duration = animateDuration
        groupAnimation.animations = [hTranslateAnimation,
                                     vTranslateAnimation,
                                     rotationAnimation,
                                     positionAnimation,
                                     opacityAnimation]

        return groupAnimation
    }

    fileprivate func createHorizontalTranslateAnimation(xPosition: CGPoint) -> CAKeyframeAnimation {
        let translateAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        translateAnimation.values = [0, xPosition.x, 0]
        translateAnimation.keyTimes = [0, 0.7, 1]
        translateAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        return translateAnimation
    }

    fileprivate func createVerticalTranslateAnimation(yPosition: CGPoint) -> CAKeyframeAnimation {
        let translateAnimation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        translateAnimation.values = [0, yPosition.y, 0]
        translateAnimation.keyTimes = [0, 0.7, 1]
        translateAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut
        )

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
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

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

//extension UIView {
//    func setAnchorPoint(_ point: CGPoint) {
//        let oldOrigin = frame.origin
//        layer.anchorPoint = point
//        let newOrigin = frame.origin
//
//        let transition = CGPoint(x: newOrigin.x - oldOrigin.x, y: newOrigin.y - oldOrigin.y)
//
//        self.layer.position.x += transition.x
//        self.layer.position.y += transition.y
////        self.center = CGPoint(x: center.x - transition.x, y: center.y - transition.y)
//    }
//
//    func getRotationPoint(rotationPoint: CGPoint) {
//
//        let minX = self.frame.minX
//        let minY = self.frame.minY
//        let width = self.frame.width
//        let height = self.frame.height
//
//        let anchorPoint = CGPoint(x: (rotationPoint.x - minX)/width, y:  (rotationPoint.y - minY)/height)
//
//
//        self.layer.anchorPoint = anchorPoint
//        self.layer.position = rotationPoint
//
//    }
//}
