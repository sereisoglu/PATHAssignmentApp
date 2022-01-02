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
    case pt14
    case pt18
    case pt20
    case pt22
    case pt30
    
    var value: CGSize {
        switch self {
        case .pt14:
            return .equalEdge(14)
        case .pt18:
            return .equalEdge(18)
        case .pt20:
            return .equalEdge(20)
        case .pt22:
            return .equalEdge(22)
        case .pt30:
            return .equalEdge(30)
        }
    }
}
