//
//  ProfileConfigurator.swift
//  Vocabrurary
//
//  Created by Alexandr Lobanov on 29.06.2020.
//  Copyright © 2020 Alexandr Lobanov. All rights reserved.
//

import UIKit

struct ProfileConfigurator {
    static func buildProfileModule(coordinator: Coordinatable)-> Presentable  {
        
        let viewController = ProfileViewController()
        let view = ProfileView()
        let presenter = ProfilePresenter()
        let interactor = ProfileInteractor()
        
        viewController.profileView = view
        viewController.interactor = interactor
        viewController.presenter = presenter
        
        interactor.presenter = presenter
        interactor.coordinator = coordinator
        presenter.viewController = viewController
        
        return viewController
    }
}
