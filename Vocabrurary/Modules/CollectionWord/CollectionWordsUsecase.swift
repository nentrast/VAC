//
//  CollectionWordsUsecase.swift
//  Vocabrurary
//
//  Created by Alexandr Lobanov on 03.06.2020.
//  Copyright © 2020 Alexandr Lobanov. All rights reserved.
//

import Foundation

protocol CollectionWordsUsecaseInput: class {
    func getCollection()
}

class CollectionWordsUsecase: CollectionWordsUsecaseInput, UsecaseFailureReusltHandler, UsecaseSuccessResultHandler {
    
    weak var presenter: CollectionWordsUsecasePresentable?
    var repository: WordRepositoryInput?
    var coordinator: CoordinatorDissmisable?
    
    enum Collection {
        case all, collection(name: String)
    }
    
    
    private let collection: Collection
    
    init(for collection: Collection) {
        self.collection = collection
    }

    func getCollection() {
        switch collection {
        case .all:
            repository?.getAll(completion: { (result) in
                switch result {
                case .failure(let error):
                    self.handlerError(error)
                case .success(let objects):
                    self.handleSuccess(objects)
                }
            })
        case .collection(name: let name):
            break
        }
        // if  .all return all items if collection has name - return collectiin with this name collection(name: "staff")
        // this is how I see how to use this class twice and more without copy/paste
    }
    
    func handleSuccess<T>(_ model: T) where T : Decodable, T : Encodable {
        switch model {
        case let words as [Word]:
            presenter?.add(words)
        default:
            break
        }
    }
    
    func handlerError(_ error: Error) {
        
    }
    
}
