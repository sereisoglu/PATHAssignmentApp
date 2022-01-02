//
//  Endpoint.swift
//  MarvelAPI
//
//  Created by Saffet Emin Reisoğlu on 31.12.2021.
//

import Foundation
import Alamofire

public enum Endpoint: Equatable {
    case characters(query: String?)
    case characterComics(id: Int, lastDate: String)
}

extension Endpoint {
    var urlString: String {
        return "\(MarvelAPI.shared.BASE_URL)/\(version)/public/\(path)"
    }
    
    var version: String {
        return "v1"
    }
    
    var path: String {
        switch self {
        case .characters:
            return "characters"
            
        case .characterComics(let id, _):
            return "characters/\(id)/comics"
        }
    }
}

extension Endpoint {
    var httpMethod: HTTPMethod {
        switch self {
        case .characters,
             .characterComics:
            return .get
        }
    }
}

extension Endpoint {
    var headers: HTTPHeaders? {
        switch self {
        case .characters,
             .characterComics:
            return nil
        }
    }
}

extension Endpoint {
    var parameters: Parameters? {
        let ts = String(Date().timeIntervalSince1970)
        let hash = CommonCryptoUtility.MD5(text: "\(ts)\(MarvelAPI.shared.PRIVATE_KEY)\(MarvelAPI.shared.PUBLIC_KEY)") ?? ""
        
        switch self {
        case .characters(let query):
            let temp: [String : Any?] = [
                "apikey": MarvelAPI.shared.PUBLIC_KEY,
                "limit": MarvelAPI.shared.PAGE_LIMIT,
                "ts": ts,
                "hash": hash,
                "nameStartsWith": query
            ]
            
            return temp.compactMapValues { $0 }
            
        case .characterComics(_, let lastDate):
            return [
                "apikey": MarvelAPI.shared.PUBLIC_KEY,
                "limit": 10,
                "ts": ts,
                "hash": hash,
                "format": "comic",
                "formatType": "comic",
                "dateRange": "2005-01-01,\(lastDate)",
                "orderBy": "-onsaleDate"
            ]
        }
    }
}
