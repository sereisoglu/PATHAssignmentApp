//
//  CharactersViewModel.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 31.12.2021.
//

import Foundation

protocol CharactersViewModelDelegate: AnyObject {
    func getDataForCharactersViewModel(error: ErrorModel?)
}

final class CharactersViewModel {
    weak var delegate: CharactersViewModelDelegate?
    
    private(set) var characters: [CharacterModel]?
    
    func fetchData() {
        MarvelAPI.shared.request(
            endpoint: .characters(query: nil),
            page: 1
        ) { [weak self] (result: Result<PaginationModel<CharacterModel>?, ErrorModel>) in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let data):
                self.characters = data?.data?.results
                self.delegate?.getDataForCharactersViewModel(error: nil)
                
                
            case .failure(let error):
                print(error)
                self.delegate?.getDataForCharactersViewModel(error: error)
            }
        }
    }
}
