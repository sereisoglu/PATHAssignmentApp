//
//  ResultsModel.swift
//  MarvelAPI
//
//  Created by Saffet Emin Reisoğlu on 31.12.2021.
//

import Foundation

public struct ResultsModel<T: Decodable>: Decodable {
    public var data: ResultsDataModel<T>?
}

public struct ResultsDataModel<T: Decodable>: Decodable {
    public var offset: Int?
    public var limit: Int?
    public var total: Int?
    public var count: Int?
    public var results: [T]
}
