//
//  CharactersDetailViewModel.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 1.01.2022.
//

import Foundation

protocol CharactersDetailViewModelDelegate: AnyObject {
    func getDataForCharactersDetailViewModel(error: ErrorModel?)
}

final class CharactersDetailViewModel {
    weak var delegate: CharactersDetailViewModelDelegate?
    
    private(set) var data: CharacterModel
    private(set) var comics: [ComicModel]?
    private(set) var comicCount: Int?
    
    private(set) var isFavorite: Bool = false
    
    private(set) var state: InformingState = .loading
    
    init(data: CharacterModel) {
        self.data = data
    }
}

extension CharactersDetailViewModel {
    func fetchData() {
        guard let id = data.id else {
            return
        }
        
        state = .loading
        
        MarvelAPI.shared.request(
            endpoint: .characterComics(id: id)
        ) { [weak self] (result: Result<ResultsModel<ComicModel>?, ErrorModel>) in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let data):
                let items = data?.data?.results
                let itemCount = data?.data?.total
                
                if items?.isNotEmpty ?? false {
                    self.state = .data
                    self.comics = items
                    self.comicCount = itemCount
                } else {
                    self.state = .emptyOrError(
                        headerText: "Empty",
                        messageText: "No characters"
                    )
                    self.comics = nil
                    self.comicCount = nil
                }
                
                self.delegate?.getDataForCharactersDetailViewModel(error: nil)
                
            case .failure(let error):
                self.state = .emptyOrError(
                    headerText: error.title ?? "API Error",
                    messageText: error.message ?? "An error has occurred."
                )
                
                self.delegate?.getDataForCharactersDetailViewModel(error: error)
            }
        }
    }
}
