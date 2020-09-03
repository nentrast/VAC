//
//  ProfilePresenter.swift
//  Vocabrurary
//
//  Created by Alexandr Lobanov on 29.06.2020.
//  Copyright © 2020 Alexandr Lobanov. All rights reserved.
//

import UIKit

protocol ProfilePresenterProtocol: class {
    func interactor(configureWith model: String)
//    func interactor(didRetrieveTitles titles: [Title])
//    func interactor(didFailRetrieveTitles error: Error)
//
//    func interactor(didAddTitle title: Title)
//    func interactor(didFailAddTitle error: Error)
//
//    func interactor(didDeleteTitleAtIndex index: Int)
//    func interactor(didFailDeleteTitleAtIndex index: Int)
//
//    func interactor(didFindTitle title: Title)
}

class ProfilePresenter: ProfilePresenterProtocol {
    
    weak var viewController: ProfilePresenterOutput?

    func interactor(configureWith model: String) {
        viewController?.presenter(configure: model)
    }
}
