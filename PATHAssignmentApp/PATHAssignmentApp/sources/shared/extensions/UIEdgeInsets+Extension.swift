//
//  UIEdgeInsets+Extension.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 1.01.2022.
//

import UIKit

extension UIEdgeInsets {
    static func linearSides(v vertical: CGFloat, h horizontal: CGFloat) -> UIEdgeInsets {
        return .init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
}
