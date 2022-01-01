//
//  UINavigationController+Extension.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 1.01.2022.
//

import UIKit

extension UINavigationController {
    func hidesBottomBarPushViewController(_ viewController: UIViewController, animated: Bool) {
        viewControllers.last?.hidesBottomBarWhenPushed = true
        pushViewController(viewController, animated: animated)
        viewControllers.first?.hidesBottomBarWhenPushed = false
    }
}
