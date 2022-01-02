//
//  ComicsCell.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 1.01.2022.
//

import UIKit
import LBTATools

final class ComicsCell: UITableViewCell {
    private let photoImageView = PhotoImageView(cornerRadius: 6, borderWidth: 1)
    private let nameLabel = Label(text: nil, type: .body1, weight: .medium, color: .tintPrimary, numberOfLines: 0)
    private let dateLabel = Label(text: nil, type: .body2, weight: .medium, color: .tintSecondary, numberOfLines: 0)
    private let descriptionLabel = Label(text: nil, type: .body2, weight: .medium, color: .tintTertiary, numberOfLines: 5)
    private let iconView = IconImageView(size: .pt22, icon: .arrowUpForward, tintColor: .tintTertiary)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        separatorInset = .init(top: 0, left: 16 + 60 + 10, bottom: 0, right: 0)
        
        hstack(
            photoImageView.withSize(.init(width: 60, height: 90)),
            stack(
                nameLabel,
                dateLabel,
                descriptionLabel
            ),
            hstack(
                iconView
            ).padTop(10), spacing: 10, alignment: .top
        ).withMargins(.linearSides(v: 11, h: 16))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        photoImageView.cancelImageDownload()
    }
    
    func setData(
        imageUrl: String?,
        nameText: String,
        dateText: String?,
        descriptionText: String?
    ) {
        if let imageUrl = imageUrl {
            photoImageView.isHidden = false
            
            photoImageView.setData(imageUrl: imageUrl)
        } else {
            photoImageView.isHidden = true
        }
        
        nameLabel.setData(text: nameText)
        
        if let dateText = dateText {
            dateLabel.isHidden = false

            dateLabel.setData(text: dateText)
        } else {
            dateLabel.isHidden = true
        }
        
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
