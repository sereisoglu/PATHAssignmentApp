//
//  CoreDataManager.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 3.01.2022.
//

import Foundation
import CoreData
import MarvelAPI

final class CoreDataManager {
    private init() {}
    static let shared = CoreDataManager()
    
    //
    
    private var cdCharacters = [Int : CharacterCDModel]()
    private var cdComics = [Int : [ComicCDModel]]()
    
    private(set) var characters = [Int : CharacterModel]()
    private(set) var comics = [Int : [ComicModel]]()
    
    //
    
    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PAACDModels")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    //
    
    func start() {
        let datas = fetchData()
        
        for data in datas {
            if let characterIdInt32 = data.character?.id {
                let characterId = Int(characterIdInt32)
                
                cdCharacters[characterId] = data.character
                characters[characterId] = .init(
                    id: characterId,
                    imageUrl: data.character?.imageUrl,
                    name: data.character?.name ?? "No name",
                    description: data.character?.description_
                )
                
                if cdComics[characterId] == nil {
                    cdComics[characterId] = [ComicCDModel]()
                    comics[characterId] = [ComicModel]()
                }
                
                cdComics[characterId]?.append(data)
                comics[characterId]?.append(.init(
                    id: Int(data.id),
                    imageUrl: data.imageUrl,
                    name: data.name ?? "No name",
                    description: data.description_,
                    url: data.url,
                    date: data.date
                ))
            }
        }
    }
    
    // MARK: - CRUD
    
    // MARK: Create
    
    func createCharacter(
        data: CharacterModel,
        comics: ComicModels?
    ) {
        guard let characterId = data.id else {
            return
        }
        
        let character = CharacterCDModel(context: context)
        character.id = Int32(characterId)
        character.imageUrl = data.imageUrl
        character.name = data.name
        character.description_ = data.description
        
        cdComics[characterId] = [ComicCDModel]()
        self.comics[characterId] = [ComicModel]()
        
        comics?.forEach({ (data) in
            let comic = ComicCDModel(context: context)
            comic.id = Int32(data.id ?? 0)
            comic.imageUrl = data.imageUrl
            comic.name = data.name
            comic.description_ = data.description
            comic.url = data.url
            comic.date = data.date
            comic.character = character
            
            cdComics[characterId]?.append(comic)
            self.comics[characterId]?.append(data)
        })
        
        cdCharacters[characterId] = character
        characters[characterId] = data
        
        saveContext()
        
        NotificationCenter.default.post(
            name: .updateFavorites,
            object: nil
        )
    }
    
    // MARK: Read
    
    private func fetchData() -> [ComicCDModel] {
        let fetchRequest: NSFetchRequest<ComicCDModel> = ComicCDModel.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch let error {
            print("Failed to fetch core data:", error)
            
            return []
        }
    }
    
    // MARK: Delete
    
    func deleteCharacter(id: Int, sendNotification: Bool = true) {
        comics.removeValue(forKey: id)
        
        characters.removeValue(forKey: id)
        
        cdComics[id]?.forEach({ (cdComic) in
            context.delete(cdComic)
        })
        
        if let cdCharacter = cdCharacters[id] {
            context.delete(cdCharacter)
        }
        
        saveContext()
        
        if sendNotification {
            NotificationCenter.default.post(
                name: .updateFavorites,
                object: nil
            )
        }
    }
    
    // MARK: - Save
    
    func saveContext () {
        guard context.hasChanges else {
            return
        }
        
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
