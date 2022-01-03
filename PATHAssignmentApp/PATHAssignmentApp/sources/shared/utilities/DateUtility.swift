//
//  DateUtility.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 1.01.2022.
//

import Foundation

final class DateUtility {
    static func stringToDate(_ dateString: String?) -> Date? {
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
        guard let date = stringToDate(dateString) else {
            return nil
        }
        
        let dateFormatter = convertType.dateFormatter
        
        return dateFormatter.string(from: date)
    }
    
    static func dateFormat(
        convertType: DateFormatType,
        date: Date
    ) -> String {
        let dateFormatter = convertType.dateFormatter
        
        return dateFormatter.string(from: date)
    }
}
