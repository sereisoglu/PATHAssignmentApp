//
//  CharactersViewModel.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 31.12.2021.
//

import Foundation
import MarvelAPI

protocol CharactersViewModelDelegate: AnyObject {
    func getDataForCharactersViewModel(error: ErrorModel?)
}

final class CharactersViewModel {
    weak var delegate: CharactersViewModelDelegate?
    
    private(set) var data: PaginationModel<CharacterModel>?
    
    private(set) var state: InformingState = .loading
}

extension CharactersViewModel {
    func fetchData() {
        state = .loading
        
        MarvelAPI.shared.request(
            endpoint: .characters(query: nil),
            page: 1
        ) { [weak self] (result: Result<ResultsModel<CharacterModel>?, ErrorModel>) in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let data):
                let items = data?.data?.results
                let itemCount = data?.data?.total
                
                if items?.isNotEmpty ?? false {
                    self.state = .data
                    self.data = .init(itemCount: itemCount ?? 0, items: items ?? [])
                } else {
                    self.state = .emptyOrError(
                        headerText: "Empty",
                        messageText: "No characters"
                    )
                    self.data = nil
                }
                
                self.delegate?.getDataForCharactersViewModel(error: nil)
                
            case .failure(let error):
                self.state = .emptyOrError(
                    headerText: error.title ?? "API Error",
                    messageText: error.message ?? "An error has occurred."
                )
                
                self.delegate?.getDataForCharactersViewModel(error: error)
            }
        }
    }
}

extension CharactersViewModel {
    func fetchDataForPagination() {
        data?.setIsPaginating(isPaginating: true)
        data?.increasePage()
        
        MarvelAPI.shared.request(
            endpoint: .characters(query: nil),
            page: data?.page ?? 2
        ) { [weak self] (result: Result<ResultsModel<CharacterModel>?, ErrorModel>) in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let data):
                let items = data?.data?.results
                
                self.data?.appendItems(items: items)
                
                self.delegate?.getDataForCharactersViewModel(error: nil)
                
            case .failure(let error):
                self.state = .emptyOrError(
                    headerText: error.title ?? "API Error",
                    messageText: error.message ?? "An error has occurred."
                )
                
                self.delegate?.getDataForCharactersViewModel(error: error)
            }
            
            self.data?.setIsPaginating(isPaginating: false)
        }
    }
}
