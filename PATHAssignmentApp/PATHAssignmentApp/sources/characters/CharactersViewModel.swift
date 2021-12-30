//
//  CharactersViewModel.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 31.12.2021.
//

import Foundation

final class CharactersViewModel {
    func fetchData() {
        MarvelAPI.shared.request(
            endpoint: .characters(query: nil),
            page: 1
        ) { [weak self] (result: Swift.Result<PaginationModel<CharacterModel>?, ErrorModel>) in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let data):
                print(data)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
