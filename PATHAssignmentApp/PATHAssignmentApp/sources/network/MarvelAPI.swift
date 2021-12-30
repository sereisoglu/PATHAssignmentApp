//
//  MarvelAPI.swift
//  MarvelAPI
//
//  Created by Saffet Emin Reisoğlu on 31.12.2021.
//

import Foundation
import Alamofire

public final class MarvelAPI {
    private init() {}
    public static let shared = MarvelAPI()
    
    let BASE_URL = "https://gateway.marvel.com:443"
    var PUBLIC_KEY = "ec30eabca34f321333f8f82fc087aaed"
    var PRIVATE_KEY = "7c10029ca0db1fa0a1618153575e4f84c6c0b55a"
    var PAGE_LIMIT = 30
    
    public func setUp(
        publicKey: String,
        privateKey: String,
        pageLimit: Int
    ) {
        self.PUBLIC_KEY = publicKey
        self.PRIVATE_KEY = privateKey
        self.PAGE_LIMIT = pageLimit
    }
    
    public func request<T: Decodable>(
        endpoint: Endpoint,
        page: Int? = nil,
        completion: @escaping (Result<T?, ErrorModel>) -> Void
    ) {
        var parameters = endpoint.parameters
        
//        if let page = page {
//            if parameters == nil {
//                parameters = Parameters()
//            }
//            
//            parameters?["page"] = page
//        }
        
        print("\(endpoint.httpMethod.rawValue) REQUEST\nurl: \(endpoint.urlString)\nparameters: \(parameters ?? Parameters())\n")
        
        let dataRequest = AF.request(
            endpoint.urlString,
            method: endpoint.httpMethod,
            parameters: parameters,
            headers: endpoint.headers
        )
        
        dataRequest.response { (result) in
            if let error = result.error {
                completion(.failure(.init(
                    title: "Internal Error",
                    message: error.localizedDescription
                )))
                
                return
            }
            
            guard let response = result.response else {
                completion(.failure(.init(
                    title: "Nil Response",
                    message: "An error has occurred."
                )))
                
                return
            }
            
            if (200 ..< 300) ~= response.statusCode { // success
                if let data = result.data {
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        
                        completion(.success(decodedData))
                    } catch {
                        print(error)
                        
                        completion(.failure(.init(
                            title: "\(T.self) Decode Error",
                            message: error.localizedDescription
                        )))
                    }
                } else {
                    completion(.success(nil))
                }
            } else { // failure
                if let data = result.data {
                    do {
                        let decodedData = try JSONDecoder().decode(ErrorModel.self, from: data)
                        
                        completion(.failure(decodedData))
                    } catch {
                        print(error)
                        
                        completion(.failure(.init(
                            title: "\(ErrorModel.self) Decode Error",
                            message: error.localizedDescription
                        )))
                    }
                } else {
                    completion(.failure(.init(
                        title: "Nil Error",
                        message: "An error has occurred."
                    )))
                }
            }
        }
    }
}
