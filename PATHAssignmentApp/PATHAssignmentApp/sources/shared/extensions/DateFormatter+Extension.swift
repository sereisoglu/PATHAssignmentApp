//
//  DateFormatter+Extension.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 1.01.2022.
//

import Foundation

extension DateFormatter {
    static let formatIso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatType.iso8601.rawValue
        return formatter
    }()
    
    static let formatYearAndMonthAndDay: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatType.yearAndMonthAndDay.rawValue
        return formatter
    }()
    
    static let formatMonthAndDayAndYear: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatType.monthAndDayAndYear.rawValue
        return formatter
    }()
}
