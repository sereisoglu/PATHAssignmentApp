//
//  DateFormatType.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 1.01.2022.
//

import Foundation

enum DateFormatType: String {
    case iso8601 = "yyyy-MM-dd'T'HH:mm:ssZ"
    case yearAndMonthAndDay = "YYYY-MM-DD"
    case monthAndDayAndYear = "MMM d, yyyy"
    
    var dateFormatter: DateFormatter {
        switch self {
        case .iso8601:
            return .formatIso8601
        case .yearAndMonthAndDay:
            return .formatYearAndMonthAndDay
        case .monthAndDayAndYear:
            return .formatMonthAndDayAndYear
        }
    }
}
