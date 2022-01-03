//
//  CharacterModel.swift
//  MarvelAPI
//
//  Created by Saffet Emin Reisoğlu on 31.12.2021.
//

import Foundation

public typealias CharacterModels = [CharacterModel]

public struct CharacterModel: Decodable {
    public var id: Int?
    public var imageUrl: String?
    public var name: String
    public var description: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case thumbnail
        case name
        case description
    }
    
    public init(
        id: Int?,
        imageUrl: String?,
        name: String,
        description: String?
    ) {
        self.id = id
        self.imageUrl = imageUrl
        self.name = name
        self.description = description
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int?.self, forKey: .id)
        
        let thumbnail = try values.decode(ThumbnailModel?.self, forKey: .thumbnail)
        imageUrl = thumbnail?.imageUrl
        
        name = try values.decode(String?.self, forKey: .name) ?? "No name"
        description = try values.decode(String?.self, forKey: .description)
    }
}
