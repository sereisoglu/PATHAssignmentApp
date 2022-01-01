//
//  UIView+Extension.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 1.01.2022.
//

import UIKit
import LBTATools

extension UIView {
    func addCenterInSuperview(superview: UIView, size: CGSize = .zero) {
        superview.addSubview(self)
        
        centerInSuperview(size: size)
    }
    
    open func addFillSuperview(superview: UIView,padding: UIEdgeInsets = .zero) {
        superview.addSubview(self)
        
        fillSuperview(padding: padding)
    }
}
