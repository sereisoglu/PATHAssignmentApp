//
//  CharactersDetailViewModel.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 1.01.2022.
//

import Foundation
import MarvelAPI

protocol CharactersDetailViewModelDelegate: AnyObject {
    func getDataForCharactersDetailViewModel(error: ErrorModel?)
}

final class CharactersDetailViewModel {
    weak var delegate: CharactersDetailViewModelDelegate?
    
    private(set) var data: CharacterModel
    private(set) var comics: ComicModels?
    
    private(set) var isFavorite: Bool = false
    
    private(set) var state: InformingState = .loading
    
    init(data: CharacterModel) {
        self.data = data
        
        if let id = data.id {
            isFavorite = CoreDataManager.shared.characters[id] != nil
        }
    }
}

extension CharactersDetailViewModel {
    func handleFavorite() {
        if isFavorite {
            if let id = data.id {
                CoreDataManager.shared.deleteCharacter(id: id)
            }
        } else {
            CoreDataManager.shared.createCharacter(
                data: data,
                comics: comics
            )
        }
        
        isFavorite.toggle()
    }
}

extension CharactersDetailViewModel {
    func fetchData() {
        guard let id = data.id else {
            return
        }
        
        if var items = CoreDataManager.shared.comics[id] {
            items.sort(by: { DateUtility.stringToDate($0.date)?.compare(DateUtility.stringToDate($1.date) ?? Date()) == .orderedDescending })
            
            state = .data
            comics = items
            delegate?.getDataForCharactersDetailViewModel(error: nil)
            
            return
        }
        
        state = .loading
        
        MarvelAPI.shared.request(
            endpoint: .characterComics(
                id: id,
                lastDate: DateUtility.dateFormat(convertType: .yearAndMonthAndDay, date: Date())
            )
        ) { [weak self] (result: Result<ResultsModel<ComicModel>?, ErrorModel>) in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let data):
                let items = data?.data?.results
                
                if items?.isNotEmpty ?? false {
                    self.state = .data
                    self.comics = items
                } else {
                    self.state = .emptyOrError(
                        headerText: "Empty",
                        messageText: "No characters"
                    )
                    self.comics = nil
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
