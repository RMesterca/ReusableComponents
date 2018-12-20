//
//  TabView.swift
//  TabSwitcher
//
//  Created by Raluca Mesterca on 19/12/2018.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

@IBDesignable
class TabView: UIView {

    //MARK: Inspectable Properties
    @IBInspectable var cornerRadius: CGFloat = 15 {
        didSet { setNeedsLayout() }
    }

    @IBInspectable var tabHeight: CGFloat = 50 {
        didSet { setNeedsLayout() }
    }

    @IBInspectable var fillColor: UIColor = .red {
        didSet {
            shapeLayer.fillColor = fillColor.cgColor
        }
    }

    @IBInspectable var isLeftTabView: Bool = false {
        didSet { setNeedsLayout() }
    }

    @IBInspectable var xMargin: CGFloat = 10 {
        didSet { setNeedsLayout() }
    }

    //MARK: Properties
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }

    var shapeLayer: CAShapeLayer {
        return self.layer as! CAShapeLayer
    }
    
    var roundedRect: UIBezierPath {
        let frame = CGRect(x: bounds.origin.x,
                           y: bounds.origin.y + tabHeight,
                           width: bounds.width,
                           height: bounds.height - tabHeight)
        return UIBezierPath(
            roundedRect: frame,
            cornerRadius: cornerRadius
        )
    }

    var leftLabelRoundedRect: UIBezierPath {
        let frame = CGRect(x: bounds.origin.x,
                           y: bounds.origin.y,
                           width: bounds.width/2 + xMargin,
                           height: bounds.height)
        return UIBezierPath(
            roundedRect: frame,
            cornerRadius: cornerRadius
        )
    }

    var rightLabelRoundedRect: UIBezierPath {
        let frame = CGRect(x: bounds.width/2 - xMargin,
                           y: bounds.origin.y,
                           width: bounds.width/2 + xMargin,
                           height: bounds.height)
        return UIBezierPath(
            roundedRect: frame,
            cornerRadius: cornerRadius
        )
    }

    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    //MARK: Methods
    private func setup() {
        self.shapeLayer.fillColor = self.fillColor.cgColor
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let tabPath = UIBezierPath()
        isLeftTabView ? tabPath.append(leftLabelRoundedRect) : tabPath.append(rightLabelRoundedRect)
        tabPath.append(roundedRect)
        self.shapeLayer.path = tabPath.cgPath
    }

}
