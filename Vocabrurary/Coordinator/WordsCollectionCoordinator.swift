//
//  WordsCollectionCoordinator.swift
//  Vocabrurary
//
//  Created by Alexandr Lobanov on 03.06.2020.
//  Copyright © 2020 Alexandr Lobanov. All rights reserved.
//

import UIKit

protocol WordsCoordinatorInput: class {
    func showWordsCollection(indexPath: IndexPath, collection: CollectionWordsUsecase.Collection)
}

protocol CoordinatorDissmisable: class {
    func dissmiss()
}

class WordsCollectionCoordinator: CoordinatorEngine, Coordinatable, WordsCoordinatorInput, CoordinatorDissmisable {
    var flowCompletion: (() -> Void)?
    
    func start() {
        showWordsList()
    }
    
    private func showWordsList() {
        let module = ModuleFactory().makeWordList(coordinator: self)
        router.setRootModule(module, hideBar: false)
    }
    
    func showWordsCollection(indexPath: IndexPath,
                             collection: CollectionWordsUsecase.Collection) {
        let module = ModuleFactory().makeWordCollection(coordinator: self, collection: collection, selected: indexPath)
        router.present(module, animated: true)
    }
    
    func dissmiss() {
        router.dismissModule(animated: true, completion: nil)
    }
}
