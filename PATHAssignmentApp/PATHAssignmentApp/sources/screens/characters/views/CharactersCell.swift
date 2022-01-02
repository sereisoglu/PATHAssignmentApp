//
//  CharactersCell.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 31.12.2021.
//

import UIKit
import LBTATools

final class CharactersCell: UITableViewCell {
    private let IMAGE_VIEW_SIZE: CGSize = .equalEdge(75)
    
    private let photoImageView = PhotoImageView(cornerRadius: 8, borderWidth: 1)
    private let nameLabel = Label(text: nil, type: .body1, weight: .medium, color: .tintPrimary, numberOfLines: 0)
    private let descriptionLabel = Label(text: nil, type: .body2, weight: .medium, color: .tintSecondary, numberOfLines: 5)
    private let iconView = IconImageView(size: .pt22, icon: .chevronForward, tintColor: .tintTertiary)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        separatorInset = .init(
            top: 0,
            left: Space.pt16.value + IMAGE_VIEW_SIZE.width + Space.pt10.value,
            bottom: 0,
            right: 0
        )
        
        hstack(
            photoImageView.withSize(IMAGE_VIEW_SIZE),
            stack(
                nameLabel,
                descriptionLabel
            ),
            hstack(
                iconView
            ).padTop(Space.pt10.value), spacing: Space.pt10.value, alignment: .top
        ).withMargins(.linearSides(v: Space.pt11.value, h: Space.pt16.value))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        photoImageView.cancelImageDownload()
    }
    
    func setData(
        imageUrl: String?,
        nameText: String,
        descriptionText: String?
    ) {
        if let imageUrl = imageUrl {
            photoImageView.isHidden = false
            
            photoImageView.setData(imageUrl: imageUrl)
        } else {
            photoImageView.isHidden = true
        }
        
        nameLabel.setData(text: nameText)
        
        if let descriptionText = descriptionText {
            descriptionLabel.isHidden = false

            descriptionLabel.setData(text: descriptionText)
        } else {
            descriptionLabel.isHidden = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
