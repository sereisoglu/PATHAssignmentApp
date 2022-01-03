//
//  FavoritesCoordinator.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 31.12.2021.
//

import UIKit
import MarvelAPI

final class FavoritesCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        
        let viewController = FavoritesController(
            viewModel: .init(),
            coordinator: self
        )
        viewController.tabBarItem.image = Icon.star.value
        viewController.tabBarItem.selectedImage = Icon.starFill.value
        viewController.title = "Favorites"
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToDetail(data: CharacterModel) {
        let childCoordinator = CharactersDetailCoordinator(navigationController: navigationController)
        childCoordinator.parentCoordinator = self
        childCoordinators.append(childCoordinator)
        childCoordinator.start(data: data)
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
              !navigationController.viewControllers.contains(fromViewController) else {
            return
        }
        
        if let charactersDetailController = fromViewController as? CharactersDetailController {
            childCoordinatorDidFinish(childCoordinator: charactersDetailController.coordinator)
        }
    }
}
