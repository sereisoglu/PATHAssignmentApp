//
//  Shared.swift
//  MarvelAPI
//
//  Created by Saffet Emin Reisoğlu on 31.12.2021.
//

import Foundation

struct ThumbnailModel: Decodable {
    var path: String?
    var `extension`: String?
    
    var imageUrl: String? {
        guard let path = path,
              let `extension` = `extension` else {
            return nil
        }
        
        return "\(path).\(`extension`)"
    }
}

struct DateModel: Decodable {
    var type: String?
    var date: String?
}

struct URLModel: Decodable {
    var type: String?
    var url: String?
}
