//
//  CharactersSearchResultsViewModel.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 1.01.2022.
//

import Foundation
import MarvelAPI

protocol CharactersSearchResultsViewModelDelegate: AnyObject {
    func getDataForCharactersSearchResultsViewModel(error: ErrorModel?)
}

final class CharactersSearchResultsViewModel {
    weak var delegate: CharactersSearchResultsViewModelDelegate?
    
    private(set) var data: PaginationModel<CharacterModel>?
    
    private(set) var state: InformingState = .data
    
    private(set) var query: String = ""
    
    init() {
        reset()
    }
    
    func reset() {
        data = nil

        state = .emptyOrError(
            headerText: "Start Searching",
            messageText: "Search all of PAA for characters."
        )

        query = ""
    }
}

extension CharactersSearchResultsViewModel {
    func fetchData(query: String) {
        guard self.query != query else {
            return
        }

        self.query = query

        state = .loading
        
        MarvelAPI.shared.request(
            endpoint: .characters(query: query),
            page: 1
        ) { [weak self] (result: Result<ResultsModel<CharacterModel>?, ErrorModel>) in
            guard let self = self,
                  query == self.query else {
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
                
                self.delegate?.getDataForCharactersSearchResultsViewModel(error: nil)
                
            case .failure(let error):
                self.state = .emptyOrError(
                    headerText: error.title ?? "API Error",
                    messageText: error.message ?? "An error has occurred."
                )
                
                self.delegate?.getDataForCharactersSearchResultsViewModel(error: error)
            }
        }
    }
}

extension CharactersSearchResultsViewModel {
    func fetchDataForPagination() {
        let query = self.query
        
        data?.setIsPaginating(isPaginating: true)
        data?.increasePage()
        
        MarvelAPI.shared.request(
            endpoint: .characters(query: query),
            page: data?.page ?? 2
        ) { [weak self] (result: Result<ResultsModel<CharacterModel>?, ErrorModel>) in
            guard let self = self,
                  query == self.query else {
                return
            }
            
            switch result {
            case .success(let data):
                let items = data?.data?.results
                
                self.data?.appendItems(items: items)
                
                self.delegate?.getDataForCharactersSearchResultsViewModel(error: nil)
                
            case .failure(let error):
                self.state = .emptyOrError(
                    headerText: error.title ?? "API Error",
                    messageText: error.message ?? "An error has occurred."
                )
                
                self.delegate?.getDataForCharactersSearchResultsViewModel(error: error)
            }
            
            self.data?.setIsPaginating(isPaginating: false)
        }
    }
}
