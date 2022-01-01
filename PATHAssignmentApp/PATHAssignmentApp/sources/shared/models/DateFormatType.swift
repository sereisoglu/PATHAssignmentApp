//
//  DateFormatType.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 1.01.2022.
//

import Foundation

enum DateFormatType: String {
    case iso8601 = "yyyy-MM-dd'T'HH:mm:ssZ" // "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case monthAndDayAndYear = "MMM d, yyyy"
    case monthAndDayAndYearAndDayNameAndTime = "MMM d, yyyy EEE 'at' hh:mm a"
}
