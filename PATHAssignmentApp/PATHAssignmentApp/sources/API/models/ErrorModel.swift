//
//  ErrorModel.swift
//  MarvelAPI
//
//  Created by Saffet Emin Reisoğlu on 31.12.2021.
//

import Foundation

public struct ErrorModel: Decodable, Error {
    public var title: String?
    
    public var code: Int?
    public var message: String?
    
    enum CodingKeys: String, CodingKey {
        case code
        case message
    }
}
