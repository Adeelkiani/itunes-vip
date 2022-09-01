//
//  AppCoordinator.swift
//  itunes-vip
//
//  Created by Adeel kiani on 31/08/2022.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
  var navigationController: UINavigationController { get set }
  func openViewController(data: Any?)
  func popViewController()
}

extension Coordinator {
    func popViewController() {
        navigationController.popViewController(animated: true)
    }
}

final class AppCoordinator: Coordinator {
  
  var navigationController: UINavigationController
  
    // MARK: - Properties
   private let window: UIWindow

   // MARK: - Initializer
   init(navController: UINavigationController, window: UIWindow) {
     self.navigationController = navController
     self.window = window
      self.navigationController.hideNavigationBar()
   }
  
  func openViewController(data: Any?) {
      window.rootViewController = navigationController
      window.makeKeyAndVisible()
      navigateToHome()
  }

  // MARK: - Navigation
  private func navigateToHome() {

      let coordinator = HomeCoordinator(navigationController: navigationController)
      coordinator.appCoordinator = self
      coordinator.openViewController(data: nil)
  }

}

// MARK: - UINavigationController Extension
 extension UINavigationController {
    func hideNavigationBar() {
        navigationBar.isHidden = true
        interactivePopGestureRecognizer?.isEnabled = false
    }
}
