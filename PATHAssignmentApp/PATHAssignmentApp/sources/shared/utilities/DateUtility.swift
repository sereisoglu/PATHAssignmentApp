//
//  DateUtility.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 1.01.2022.
//

import Foundation

final class DateUtility {
    static private func stringToDate(_ dateString: String?) -> Date? {
        guard let dateString = dateString else {
            return nil
        }
        
        let dateFormatter = DateFormatter.formatIso8601
        
        return dateFormatter.date(from: dateString)
    }
    
    static func stringFormat(
        convertType: DateFormatType,
        dateString: String?
    ) -> String? {
        guard var date = stringToDate(dateString) else {
            return nil
        }
        
        date.addTimeInterval(TimeInterval(TimeZone(identifier: TimeZone.current.identifier)?.secondsFromGMT() ?? 0))
        
        let dateFormatter: DateFormatter
        switch convertType {
        case .iso8601:
            dateFormatter = DateFormatter.formatIso8601
        case .monthAndDayAndYear:
            dateFormatter = DateFormatter.formatMonthAndDayAndYear
        case .monthAndDayAndYearAndDayNameAndTime:
            dateFormatter = DateFormatter.formatMonthAndDayAndYearAndDayNameAndTime
        }
        
        return dateFormatter.string(from: date)
    }
}
