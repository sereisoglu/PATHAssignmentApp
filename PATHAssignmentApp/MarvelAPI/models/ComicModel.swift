//
//  ComicModel.swift
//  MarvelAPI
//
//  Created by Saffet Emin Reisoğlu on 31.12.2021.
//

import Foundation

public struct ComicModel: Decodable {
    public var id: Int?
    public var thumbnail: ThumbnailModel?
    public var title: String?
    public var description: String?
    public var pageCount: Int?
    public var urls: [URLModel]?
    public var dates: [DateModel]?
    
    public var url: String? {
        urls?.first(where: { $0.type == "detail" })?.url
    }
    
    public var date: String? {
        dates?.first(where: { $0.type == "onsaleDate" })?.date
    }
}
