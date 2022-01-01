//
//  CharacterModel.swift
//  MarvelAPI
//
//  Created by Saffet Emin Reisoğlu on 31.12.2021.
//

import Foundation

struct CharacterModel: Decodable {
    var id: Int?
    var thumbnail: ThumbnailModel?
    var name: String?
    var description: String?
    
    var imageUrl: String? {
        guard let path = thumbnail?.path,
              let `extension` = thumbnail?.extension else {
            return nil
        }
        
        return "\(path).\(`extension`)"
    }
}
