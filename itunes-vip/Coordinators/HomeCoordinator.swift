//
//  HomeCoordinator.swift
//  itunes-vip
//
//  Created by Adeel kiani on 31/08/2022.
//

import Foundation
import UIKit

protocol HomeCoordinatorDelegate:Coordinator {
}

class HomeCoordinator: HomeCoordinatorDelegate {
    
    var navigationController: UINavigationController
    weak var appCoordinator: AppCoordinator!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func openViewController(data:Any?) {
        
        let viewController = HomeViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
        navigationController.viewControllers = [viewController]
        
    }
    func navigateToEmailSignIn() {
        let coordinator = EmailSignInCoordinator(navigationController: navigationController)
        coordinator.openViewController(data: nil)
    }
    
    func popViewController() {
        
    }
}
