//
//  PhotoImageView.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 31.12.2021.
//

import UIKit
import Nuke

final class PhotoImageView: UIImageView {
    init(
        cornerRadius: CGFloat = 10,
        borderWidth: CGFloat = .zero
    ) {
        super.init(frame: .zero)
        
        backgroundColor = Color.fillPrimary.value
        
        layer.cornerRadius = 10
        if #available(iOS 13.0, *) {
            layer.cornerCurve = .continuous
        }
        clipsToBounds = true
        
        layer.borderWidth = borderWidth
        layer.borderColor = Color.tintPrimary.value.withAlphaComponent(0.25).cgColor
        frame = frame.insetBy(dx: -borderWidth, dy: -borderWidth)
        
        contentMode = .scaleAspectFill
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if #available(iOS 13.0, *),
           traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            layer.borderColor = Color.tintPrimary.value.withAlphaComponent(0.25).cgColor
        }
    }
    
    func setData(imageUrl: String?) {
        guard let imageUrl = imageUrl,
              let url = URL(string: imageUrl) else {
            isHidden = true
            
            return
        }
        
        Nuke.loadImage(
            with: url,
            options: .init(
                transition: .fadeIn(duration: 0.33)
            ),
            into: self
        )
    }
    
    func cancelImageDownload() {
        Nuke.cancelRequest(for: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
