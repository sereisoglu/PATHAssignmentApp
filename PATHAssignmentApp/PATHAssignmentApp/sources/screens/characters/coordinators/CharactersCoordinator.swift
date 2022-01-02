//
//  CharactersCoordinator.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 31.12.2021.
//

import UIKit

final class CharactersCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = CharactersController(
            viewModel: .init(),
            searchResultsViewModel: .init(),
            coordinator: self
        )
        viewController.tabBarItem.image = Icon.person3.value
        viewController.tabBarItem.selectedImage = Icon.person3Fill.value
        viewController.title = "Characters"
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToDetail(data: CharacterModel) {
        let viewController = CharactersDetailController(
            viewModel: .init(data: data)
        )
        navigationController.pushViewController(viewController, animated: true)
    }
}
