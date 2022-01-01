//
//  ResultsModel.swift
//  MarvelAPI
//
//  Created by Saffet Emin Reisoğlu on 31.12.2021.
//

import Foundation

struct ResultsModel<T: Decodable>: Decodable {
    var data: ResultsDataModel<T>?
}

struct ResultsDataModel<T: Decodable>: Decodable {
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var results: [T]
}
