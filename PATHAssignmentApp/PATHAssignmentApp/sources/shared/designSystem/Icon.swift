//
//  Icon.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 31.12.2021.
//

import UIKit

enum Icon: String {
    case arrowUpForward = "arrow-up-forward"
    case chevronForward = "chevron-forward"
    case person3Fill = "person-3-fill"
    case person3 = "person-3"
    case starFill = "star-fill"
    case star
    
    var value: UIImage {
        return UIImage(named: "\(rawValue)") ?? UIImage()
    }
}

enum IconSize {
    case pt22
    
    var value: CGSize {
        switch self {
        case .pt22:
            return .equalEdge(22)
        }
    }
}
