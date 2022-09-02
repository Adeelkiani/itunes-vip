//
//  AppDelegate.swift
//  itunes-vip
//
//  Created by Adeel kiani on 31/08/2022.
//

import UIKit
import ANLoader

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        prepareWindow()
        configureLoader()
        
        return true
    }
    
    func configureLoader(iconColor: UIColor = .white, textColor: UIColor = .white, loaderBackgroundColor: UIColor = .darkGray) {
        ANLoader.activityColor = iconColor
        ANLoader.activityTextColor = textColor
        ANLoader.activityBackgroundColor = loaderBackgroundColor
        ANLoader.activityTextFontName = Fonts.font(fontWeight: .book, fontSize: 16)
    }
}

extension AppDelegate {
    
    private func prepareWindow() {
        
        let window = UIWindow(frame: UIScreen.main.bounds)

        let navController = UINavigationController()
        let appCoordinator = AppCoordinator(navController: navController, window: window)
        self.appCoordinator = appCoordinator
        appCoordinator.openViewController(data: nil)
        
    }
}
