//
//  ContentCoordinator.swift
//  Itunesvip
//
//  Created by Adeel kiani on 02/09/2022.
//

import Foundation
import UIKit

protocol ContentCoordinatorDelegate: Coordinator {
    func navigateToDetails(mediaType: MediaTypes, content: ContentPayload)
}

class ContentCoordinator: ContentCoordinatorDelegate {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func openViewController(data: Any?) {
        
        guard let _content = data as? [String: [ContentPayload]] else {
            print("Invalid content")
            return
        }
        
        let viewController = ContentViewController()
        let interactor = ContentInteractor(content: _content)
        let presenter = ContentPresenter()
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.view = viewController
        viewController.coordinator = self
        
        navigationController.pushViewController(viewController, animated: true)
        
    }

    func navigateToDetails(mediaType: MediaTypes, content: ContentPayload) {
    
        let viewController = ContentDetailsViewController(mediaType: mediaType, content: content)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)

    }
    
}
