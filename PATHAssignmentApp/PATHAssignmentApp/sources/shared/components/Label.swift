//
//  Label.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 31.12.2021.
//

import UIKit

final class Label: UILabel {
    private var attributes: [NSAttributedString.Key : Any]
    
    init(
        text: String?,
        type: FontType,
        weight: FontWeight,
        color: Color?,
        alignment: NSTextAlignment = .left,
        numberOfLines: Int = 1,
        lineBreakMode: NSLineBreakMode = .byTruncatingTail
    ) {
        attributes = AttributedStringUtility.generate(type: type, weight: weight, color: nil, alignment: alignment, lineBreakMode: lineBreakMode)
        
        super.init(frame: .zero)
        
        self.numberOfLines = numberOfLines
        
        setData(text: text)
        setData(color: color)
        
        sizeToFit()
    }
    
    func setData(text: String?) {
        guard let text = text else {
            return
        }
        
        attributedText = .init(string: text, attributes: attributes)
    }
    
    func setData(color: Color?) {
        guard let color = color else {
            return
        }
        
        textColor = color.value
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
