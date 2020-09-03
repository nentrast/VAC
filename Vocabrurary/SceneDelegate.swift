//
//  SceneDelegate.swift
//  Vocabrurary
//
//  Created by Alexandr Lobanov on 31.05.2020.
//  Copyright © 2020 Alexandr Lobanov. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    private var appCoordinator: AppCoordinator!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let navigation = UINavigationController()        
        let router = Router(rootController: navigation)
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        
        appCoordinator = AppCoordinator(router: router)
        appCoordinator.start()
    }
}

