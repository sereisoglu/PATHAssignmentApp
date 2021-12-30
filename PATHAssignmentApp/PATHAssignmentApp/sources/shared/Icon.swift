//
//  Icon.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 31.12.2021.
//

import UIKit

enum Icon: String {
    case person3Fill = "person-3-fill"
    case person3 = "person-3"
    case starFill = "star-fill"
    case star
    
    var value: UIImage {
        return UIImage(named: "\(rawValue)") ?? UIImage()
    }
}
