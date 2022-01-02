//
//  ComicModel.swift
//  MarvelAPI
//
//  Created by Saffet Emin Reisoğlu on 31.12.2021.
//

import Foundation

struct ComicModel: Decodable {
    var id: Int?
    var thumbnail: ThumbnailModel?
    var title: String?
    var description: String?
    var pageCount: Int?
    var urls: [URLModel]?
    var dates: [DateModel]?
    
    var url: String? {
        urls?.first(where: { $0.type == "detail" })?.url
    }
    
    var date: String? {
        guard let dateString = dates?.first(where: { $0.type == "onsaleDate" })?.date else {
            return nil
        }
        
        return DateUtility.stringFormat(convertType: .monthAndDayAndYear, dateString: dateString)
    }
}
