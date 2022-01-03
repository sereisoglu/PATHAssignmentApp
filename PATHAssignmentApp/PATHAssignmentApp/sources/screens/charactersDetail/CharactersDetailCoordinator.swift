//
//  CharactersDetailCoordinator.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 1.01.2022.
//

import UIKit
import MarvelAPI

final class CharactersDetailCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(data: CharacterModel) {
        let viewController = CharactersDetailController(
            viewModel: .init(data: data),
            coordinator: self
        )
        navigationController.pushViewController(viewController, animated: true)
    }
}
