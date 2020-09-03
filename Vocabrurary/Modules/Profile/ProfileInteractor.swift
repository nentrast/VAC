//
//  ProfileInteractor.swift
//  Vocabrurary
//
//  Created by Alexandr Lobanov on 29.06.2020.
//  Copyright © 2020 Alexandr Lobanov. All rights reserved.
//

import UIKit

protocol ProfileInteractorProtocol: class {
    func viewDidLoad()
}

class ProfileInteractor: ProfileInteractorProtocol {

    var presenter: ProfilePresenter?
    var coordinator: Coordinatable?
    
    func viewDidLoad() {
        // TODO: = here presenter is called
    }
}
