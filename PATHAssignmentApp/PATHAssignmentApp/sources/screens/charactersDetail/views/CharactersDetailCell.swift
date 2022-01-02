//
//  CharactersDetailCell.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 1.01.2022.
//

import UIKit
import LBTATools

final class CharactersDetailCell: UITableViewCell {
    private let IMAGE_VIEW_SIZE: CGSize = .equalEdge(120)
    
    private let photoImageView = PhotoImageView(cornerRadius: 10, borderWidth: 2)
    private let nameLabel = Label(text: nil, type: .title3, weight: .bold, color: .tintPrimary, alignment: .center, numberOfLines: 0)
    private let descriptionLabel = Label(text: nil, type: .body1, weight: .medium, color: .tintSecondary, alignment: .center, numberOfLines: 0)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        stack(
            photoImageView.withSize(IMAGE_VIEW_SIZE),
            stack(
                nameLabel,
                descriptionLabel
            ), spacing: Space.pt20.value, alignment: .center
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
