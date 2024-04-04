//
//  SceneDelegate.swift
//  WeatherDemoApp
//
//  Created by ahmed on 01/04/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            self.window = window
            
            /// replace value with .dark or .light to change theme color
            window.overrideUserInterfaceStyle = .dark

            let citiesViewModel = CitiesViewModel()
            let viewControlller = CitiesViewController(viewModel: citiesViewModel)
            
            let navController = UINavigationController()
            navController.setViewControllers([viewControlller], animated: false)
            
            self.window?.rootViewController = navController
            window.makeKeyAndVisible()
            
        }
    }

}
