//
//  Storyboardable.swift
//  TabSwitcher
//
//  Created by Raluca Mesterca on 19/12/2018.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation
import UIKit

protocol Storyboardable: class {

    static var storyboardName: String { get }
    static var storyboardIdentifier: String { get }
}

extension Storyboardable {
    static func instantiate() -> Self {
        let bundle = Bundle(for: AppDelegate.self)
        let storyboard = UIStoryboard(
            name: storyboardName,
            bundle: bundle)

        return storyboard.instantiateViewController(
            withIdentifier: storyboardIdentifier) as! Self
    }
}
