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
}
