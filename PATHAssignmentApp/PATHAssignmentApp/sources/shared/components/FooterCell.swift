//
//  FooterCell.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 1.01.2022.
//

import UIKit
import LBTATools

final class FooterCell: UITableViewHeaderFooterView {
    private let activityIndicatorView = ActivityIndicatorView(size: .pt30, tintColor: .tintSecondary)
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        activityIndicatorView.addCenterInSuperview(superview: self)
    }
    
    func setData(animating: Bool) {
        activityIndicatorView.animating = animating
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
