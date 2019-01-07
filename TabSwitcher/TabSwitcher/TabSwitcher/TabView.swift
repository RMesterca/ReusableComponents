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

    @IBInspectable var xMargin: CGFloat = 10 {
        didSet { setNeedsLayout() }
    }

    @IBInspectable var isLeftTabView: Bool = false {
        didSet { setNeedsLayout() }
    }

    @IBInspectable var segueName: String?

    //MARK: Properties
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }

    var shapeLayer: CAShapeLayer {
        return self.layer as! CAShapeLayer
    }
    var tabBarHeight: CGFloat = 0
    
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
                           height: tabHeight + cornerRadius)
        return UIBezierPath(
            roundedRect: frame,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
    }

    var rightLabelRoundedRect: UIBezierPath {
        let frame = CGRect(x: bounds.width/2 - xMargin,
                           y: bounds.origin.y,
                           width: bounds.width/2 + xMargin,
                           height: tabHeight + cornerRadius)
        return UIBezierPath(
            roundedRect: frame,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
    }

    lazy var containerView = UIView()

    lazy var containerViewFrame: CGRect = {
        return CGRect(
            x: 0,
            y: tabHeight,
            width: self.frame.size.width,
            height: self.frame.size.height
        )
    }()

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
        if let scrollView = self.containerView.subviews.first as? UIScrollView {
            scrollView.contentInset.bottom = tabBarHeight
        }

        self.shapeLayer.fillColor = self.fillColor.cgColor
//        self.addSubview(containerView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        setViewLayerBezierPath()

        containerView.frame = containerViewFrame
//        containerView.backgroundColor = se
    }

    fileprivate func setViewLayerBezierPath() {
        let tabPath = UIBezierPath()
        isLeftTabView ? tabPath.append(leftLabelRoundedRect) : tabPath.append(rightLabelRoundedRect)
        tabPath.append(roundedRect)
        self.shapeLayer.path = tabPath.cgPath
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let view = super.hitTest(point, with: event)
            else { return nil }

        if isLeftTabView,
            rightLabelRoundedRect.contains(point) {
            return nil
        }

        if !isLeftTabView,
            leftLabelRoundedRect.contains(point) {
            return nil
        }

        return view
    }
}
