//
//  Coordinator.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 31.12.2021.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func childCoordinatorDidFinish(childCoordinator: Coordinator?)
}

extension Coordinator {
    func childCoordinatorDidFinish(childCoordinator: Coordinator?) {
        guard let index = childCoordinators.firstIndex(where: { $0 === childCoordinator }) else {
            return
        }
        
        childCoordinators.remove(at: index)
    }
}
