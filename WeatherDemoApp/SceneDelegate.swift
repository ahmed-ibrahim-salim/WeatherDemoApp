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
            
            let citiesViewModel = CitiesViewModel()
            let navController = UINavigationController()
            let viewControlller = CitiesViewController(viewModel: citiesViewModel)
            navController.setViewControllers([viewControlller], animated: false)
            
            self.window?.rootViewController = navController
            window.makeKeyAndVisible()
            
        }
    }

}
