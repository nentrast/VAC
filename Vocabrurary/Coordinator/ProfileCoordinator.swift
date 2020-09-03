//
//  ProfileCoordinator.swift
//  Vocabrurary
//
//  Created by Alexandr Lobanov on 29.06.2020.
//  Copyright © 2020 Alexandr Lobanov. All rights reserved.
//

import UIKit

class ProfileCoordinator: CoordinatorEngine, Coordinatable {

    var flowCompletion: (() -> Void)?
    
    func start() {
        perform()
    }
    
    private func perform() {
       let module = ProfileConfigurator.buildProfileModule(coordinator: self)
        router.setRootModule(module, hideBar: false)
    }
}
