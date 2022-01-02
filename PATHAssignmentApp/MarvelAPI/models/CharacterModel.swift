//
//  CharacterModel.swift
//  MarvelAPI
//
//  Created by Saffet Emin Reisoğlu on 31.12.2021.
//

import Foundation

public struct CharacterModel: Decodable {
    public var id: Int?
    public var thumbnail: ThumbnailModel?
    public var name: String?
    public var description: String?
}
