//
//  CharactersHeaderView.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 1.01.2022.
//

import UIKit
import LBTATools

final class CharactersHeaderView: UITableViewHeaderFooterView {
    private let headerLabel = Label(text: nil, type: .title3, weight: .bold, color: .tintPrimary, numberOfLines: 0)
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        headerLabel.addFillSuperview(
            superview: self,
            padding: .linearSides(v: Sizing.space10pt, h: Sizing.space16pt)
        )
    }
    
    func setData(text: String) {
        headerLabel.setData(text: text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
