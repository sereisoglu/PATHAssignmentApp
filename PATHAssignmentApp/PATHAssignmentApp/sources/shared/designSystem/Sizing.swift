//
//  Sizing.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 1.01.2022.
//

import UIKit

enum CornerRadius {
    case pt6
    case pt8
    case pt10
    
    var value: CGFloat {
        switch self {
        case .pt6:
            return 6
        case .pt8:
            return 8
        case .pt10:
            return 10
        }
    }
}

enum Space {
    case pt2
    case pt10
    case pt11
    case pt16
    case pt20
    
    var value: CGFloat {
        switch self {
        case .pt2:
            return 2
        case .pt10:
            return 10
        case .pt11:
            return 11
        case .pt16:
            return 16
        case .pt20:
            return 20
        }
    }
}
