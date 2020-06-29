//
//  WordsListUsecase.swift
//  Vocabrurary
//
//  Created by Alexandr Lobanov on 02.06.2020.
//  Copyright © 2020 Alexandr Lobanov. All rights reserved.
//

import Foundation

protocol WordRepositoryInput: class {
    func getAll(completion: ((Result<[Word], Error>) -> Void))
}

protocol UsecaseSuccessResultHandler: class {
    func handleSuccess<T: Codable>(_ model: T)
}

protocol UsecaseFailureReusltHandler: class {
    func handlerError(_ error: Error)
}

protocol WordsListUsecaseProtocol: UsecaseSuccessResultHandler, UsecaseFailureReusltHandler {
    func showItem(at indexPath: IndexPath, with interactor: Interactor)
    func playSound(for model: Word)
    func showCollection(for indexPath: IndexPath, model: Word)
    func showCollectionWords(for indexPath: IndexPath)
    func getListOfWords()
    func remove(item: Word)
}

class WordsListUsecase: WordsListUsecaseProtocol {
    
    let voiceSyntethizer = VoiceSynthesizeService()

    var interactor = Interactor()
    weak var presenter: WordsListUsecasePresentable?
    var coordinator: WordsCoordinatorInput?
    var repository: WordRepositoryInput?
    
    func getListOfWords() {
        repository?.getAll(completion: { result in
            switch result {
            case .failure(let error):
                self.handlerError(error)
            case .success(let models):
                self.handleSuccess(models)
            }
        })
    }
    
    func showItem(at indexPath: IndexPath, with interactor: Interactor) {
        coordinator?.showWordsCollection(indexPath: indexPath, collection: .all)
        print("shhow item wwith all list")
    }
    
    func remove(item: Word) {
        print("remove")
    }
    
    func playSound(for model: Word) {
        voiceSyntethizer.speack(it: model.translate)
    }
    
    func showCollectionWords(for indexPath: IndexPath) {
        coordinator?.showWordsCollection(indexPath: indexPath, collection: .all)
        print("shhow item wwith all list")

    }
    
    func showCollection(for indexPath: IndexPath, model: Word) {
        if let collectionName = model.collection?.name {
            coordinator?.showWordsCollection(indexPath: indexPath, collection: .collection(name: collectionName))
        }
        print("show item wwith with collection nmae")
    }
    
    // MARK: - UsecaseSuccessResultHandler
    
    func handleSuccess<T>(_ model: T) {
        switch model {
        case let words as [Word]:
            presenter?.add(words)
        default:
            break
        }
    }
    
    // MARK: - UsecaseFailureReusltHandler
    
    func handlerError(_ error: Error) {
        
    }
}
