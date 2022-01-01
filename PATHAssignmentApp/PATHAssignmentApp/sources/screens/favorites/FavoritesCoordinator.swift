//
//  FavoritesCoordinator.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 31.12.2021.
//

import UIKit

final class FavoritesCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = FavoritesController()
        viewController.tabBarItem.image = Icon.star.value
        viewController.tabBarItem.selectedImage = Icon.starFill.value
        viewController.title = "Favorites"
        navigationController.pushViewController(viewController, animated: true)
    }
}
