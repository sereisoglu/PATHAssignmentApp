//
//  ComicModel.swift
//  MarvelAPI
//
//  Created by Saffet Emin Reisoğlu on 31.12.2021.
//

import Foundation

public typealias ComicModels = [ComicModel]

public struct ComicModel: Decodable {
    public var id: Int?
    public var imageUrl: String?
    public var name: String
    public var description: String?
    public var url: String?
    public var date: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case thumbnail
        case title
        case description
        case urls
        case dates
    }
    
    public init(
        id: Int?,
        imageUrl: String?,
        name: String,
        description: String?,
        url: String?,
        date: String?
    ) {
        self.id = id
        self.imageUrl = imageUrl
        self.name = name
        self.description = description
        self.url = url
        self.date = date
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int?.self, forKey: .id)
        
        let thumbnail = try values.decode(ThumbnailModel?.self, forKey: .thumbnail)
        imageUrl = thumbnail?.imageUrl
        
        name = try values.decode(String?.self, forKey: .title) ?? "No name"
        description = try values.decode(String?.self, forKey: .description)
        
        let urls = try values.decode([URLModel]?.self, forKey: .urls)
        url = urls?.first(where: { $0.type == "detail" })?.url
        
        let dates = try values.decode([DateModel]?.self, forKey: .dates)
        date = dates?.first(where: { $0.type == "onsaleDate" })?.date
    }
}
