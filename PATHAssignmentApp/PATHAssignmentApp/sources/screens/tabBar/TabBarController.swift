//
//  TabBarController.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 31.12.2021.
//

import UIKit

final class TabBarController: UITabBarController {
    private let charactersCoordinator = CharactersCoordinator(navigationController: UINavigationController())
    private let favoritesCoordinator = FavoritesCoordinator(navigationController: UINavigationController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        charactersCoordinator.start()
        
        favoritesCoordinator.start()
        
        viewControllers = [
            charactersCoordinator.navigationController,
            favoritesCoordinator.navigationController
        ]
    }
}
