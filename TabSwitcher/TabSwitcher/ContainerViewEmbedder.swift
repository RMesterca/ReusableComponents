//
//  ContainerViewEmbedder.swift
//  TabSwitcher
//
//  Created by Raluca Mesterca on 04/01/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation
import UIKit

class ContainerViewEmbedder {
    class func add(childVC: UIViewController, in parentVC: UIViewController, to containerView: UIView) {
        childVC.willMove(toParent: parentVC)
        parentVC.addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.didMove(toParent: parentVC)

        childVC.view.frame = CGRect(
            x: 0,
            y: 0,
            width: containerView.frame.size.width,
            height: containerView.frame.size.height)
    }

    class func removeFromParent(vcArray: [UIViewController]){
        vcArray.forEach { (vc) in
            vc.willMove(toParent: nil)
            vc.view.removeFromSuperview()
            vc.removeFromParent()
        }
    }
}
