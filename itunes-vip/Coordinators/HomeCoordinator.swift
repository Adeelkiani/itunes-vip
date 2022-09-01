//
//  HomeCoordinator.swift
//  itunes-vip
//
//  Created by Adeel kiani on 31/08/2022.
//

import Foundation
import UIKit

protocol HomeCoordinatorDelegate: Coordinator {
    func navigateToDetails()
}

class HomeCoordinator: HomeCoordinatorDelegate {

    var navigationController: UINavigationController
    weak var appCoordinator: AppCoordinator!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func openViewController(data: Any?) {
        
        let viewController = HomeViewController()
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
       
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.view = viewController
        viewController.coordinator = self

        navigationController.pushViewController(viewController, animated: true)
        navigationController.viewControllers = [viewController]
        
    }
    
    func navigateToDetails() {
        
    }
    
    func popViewController() {
        
    }
}
