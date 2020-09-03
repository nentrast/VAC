//
//  ProfileViewController.swift
//  Vocabrurary
//
//  Created by Alexandr Lobanov on 29.06.2020.
//  Copyright © 2020 Alexandr Lobanov. All rights reserved.
//

import UIKit

protocol ProfilePresenterOutput: class {
    func presenter(configure username: String)
}

class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    var profileView: ProfileView?
    var interactor: ProfileInteractor?
    weak var presenter: ProfilePresenter?
        
    override func loadView() {
        super.loadView()
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.viewDidLoad()
    }
}

extension ProfileViewController: ProfilePresenterOutput {
    func presenter(configure username: String) {
        profileView?.updateUsernameLabel(with: username)
    }
}
