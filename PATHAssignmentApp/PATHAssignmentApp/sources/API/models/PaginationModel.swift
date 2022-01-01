//
//  PaginationModel.swift
//  MarvelAPI
//
//  Created by Saffet Emin Reisoğlu on 31.12.2021.
//

import Foundation

struct PaginationModel<T: Decodable>: Decodable {
    var data: PaginationDataModel<T>?
}

struct PaginationDataModel<T: Decodable>: Decodable {
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var results: [T]
}
