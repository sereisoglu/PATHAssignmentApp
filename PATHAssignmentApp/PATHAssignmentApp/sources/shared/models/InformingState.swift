//
//  InformingState.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 31.12.2021.
//

import Foundation

enum InformingState: Equatable {
    case data
    case emptyOrError(headerText: String, messageText: String)
    case loading
}
