//
//  ModuleFactory.swift
//  Vocabrurary
//
//  Created by Alexandr Lobanov on 02.06.2020.
//  Copyright © 2020 Alexandr Lobanov. All rights reserved.
//

import UIKit

class ModuleFactory {
    func makeWordList(coordinator: WordsCoordinatorInput) -> UIViewController {
        let view  = WordsListViewController()
        let presenter = WordsListPresenter()
        let usecase = WordsListUsecase()
        let repository = WordsRepository()
        
        view.presenter = presenter
        presenter.view = view
        presenter.usecase = usecase
        usecase.presenter = presenter
        usecase.repository = repository
        usecase.coordinator = coordinator
        
        return view
    }
    
    
    func makeWordCollection(coordinator: CoordinatorDissmisable, collection: CollectionWordsUsecase.Collection, selected indexPath: IndexPath) -> UIViewController {
        let view = CollectionWordsViewController()
        let presenter = CollectionWordsPresenter(selected: indexPath)
        let usecase = CollectionWordsUsecase(for: collection)
        let repository = WordsRepository()

        view.presenter = presenter
        presenter.view = view
        presenter.usecase = usecase
        usecase.presenter = presenter
        usecase.coordinator = coordinator
        usecase.repository = repository
        return view
    }
}
