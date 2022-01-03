//
//  FavoritesViewModel.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 3.01.2022.
//

import UIKit
import MarvelAPI

protocol FavoritesViewModelDelegate: AnyObject {
    func getDataForFavoritesViewModel()
}

final class FavoritesViewModel {
    weak var delegate: FavoritesViewModelDelegate?
    
    private(set) var characters = CharacterModels()
    
    private(set) var state: InformingState = .loading
    
    private var observers = [NSObjectProtocol]()
    
    init() {
        setUpObservers()
    }
    
    private func setUpObservers() {
        guard observers.isEmpty else {
            return
        }
        
        observers = [
            NotificationCenter.default.addObserver(
                forName: .updateFavorites,
                object: nil,
                queue: .main,
                using: { [weak self] (notification) in
                    guard let self = self else {
                        return
                    }
                    
                    self.fetchData()
                }
            )
        ]
    }
    
    deinit {
        observers.forEach { (observer) in
            NotificationCenter.default.removeObserver(observer)
        }
    }
}

extension FavoritesViewModel {
    func fetchData() {
        characters = []
        
        CoreDataManager.shared.characters.forEach({ (_, value) in
            characters.append(value)
        })
        
        characters.sort(by: { $0.name.compare($1.name) == .orderedAscending })
        
        if characters.isNotEmpty {
            self.state = .data
        } else {
            self.state = .emptyOrError(
                headerText: "Empty",
                messageText: "No favorites"
            )
        }
        
        delegate?.getDataForFavoritesViewModel()
    }
}

extension FavoritesViewModel {
    func delete(index: Int) {
        guard let id = characters[safe: index]?.id else {
            return
        }
        
        CoreDataManager.shared.deleteCharacter(id: id, sendNotification: true)
    }
}
