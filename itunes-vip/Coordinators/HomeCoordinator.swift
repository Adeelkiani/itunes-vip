//
//  HomeCoordinator.swift
//  itunes-vip
//
//  Created by Adeel kiani on 31/08/2022.
//

import Foundation
import UIKit

typealias MediaTypesSelectionHandler = (_ mediaTypes: [MediaTypePayload]) -> Void

protocol HomeCoordinatorDelegate: Coordinator {
    func navigateToSelectMediaTypes(mediaTypes: [MediaTypePayload], selectedMediaTypes: [MediaTypePayload], selectedTypes: @escaping MediaTypesSelectionHandler)
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
    
    func navigateToSelectMediaTypes(mediaTypes: [MediaTypePayload], selectedMediaTypes: [MediaTypePayload], selectedTypes: @escaping MediaTypesSelectionHandler) {
        
        let viewController = SelectMediaTypeViewController(mediaTypes: mediaTypes, selectedMediaTypes: selectedMediaTypes) { [weak self] mediaTypes in
            selectedTypes(mediaTypes)
        }
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func navigateToDetails() {
        
    }
    
}
