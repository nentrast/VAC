//
//  TabbarCoordinator.swift
//  Vocabrurary
//
//  Created by Alexandr Lobanov on 29.06.2020.
//  Copyright © 2020 Alexandr Lobanov. All rights reserved.
//

import UIKit

class TabBarCoordinator: CoordinatorEngine, Coordinatable {
 
    var flowCompletion: (() -> Void)?
    
    let tabBarController: UITabBarController
    
   
    override init(router: Routable) {
        tabBarController = UITabBarController()
        super.init(router: router)

        tabBarController.delegate = self
        
    }
 
    func start() {
        performTabs()
    }
    
    private func performTabs() {
        router.setRootModule(tabBarController, hideBar: false)
        
        let tabBarRouter = RouterTabBar(router: router, tabBarController: tabBarController)
        
        let wordsListCoordinator = WordsCollectionCoordinator(router: tabBarRouter)
        wordsListCoordinator.start()
//        tabBarRouter.addTab(module)
        attachChild(wordsListCoordinator)
        
        let profileCoordinator = ProfileCoordinator(router: tabBarRouter)
        profileCoordinator.start()
//        tabBarRouter.addTab(profileModule)
        
        attachChild(profileCoordinator)

        
        self.router = tabBarRouter
//        router.setRootModule(tabBarController, hideBar: false)
    }
}

extension TabBarCoordinator: UITabBarControllerDelegate {
    
}
