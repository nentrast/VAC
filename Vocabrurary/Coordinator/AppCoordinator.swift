//
//  AppCoordinator.swift
//  Vocabrurary
//
//  Created by Alexandr Lobanov on 03.06.2020.
//  Copyright © 2020 Alexandr Lobanov. All rights reserved.
//

import Foundation

class AppCoordinator: CoordinatorEngine, Coordinatable {
    var flowCompletion: (() -> Void)?
    
    func start() {
        performMain()
    }
    
    private func performMain() {
        let coordinator = TabBarCoordinator(router: router)
        
        coordinator.flowCompletion = { [weak self, weak coordinator] in
            guard let `self` = self, let `coordinator` = coordinator else {
                return
            }
            self.detachChild(coordinator)
            self.start()
        }
        
        attachChild(coordinator)
    }
    
    private func performAuth() {
        
    }
}

