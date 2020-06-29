//
//  CollectionWordsPresenter.swift
//  Vocabrurary
//
//  Created by Alexandr Lobanov on 03.06.2020.
//  Copyright © 2020 Alexandr Lobanov. All rights reserved.
//

import UIKit

protocol CollectionWordsPresenterInput: class {
    func cofigureUI(collectionView: UICollectionView)
}

protocol CollectionWordsUsecasePresentable: class {
    func add(_ items: [Word])
}

class CollectionWordsPresenter: CollectionWordsPresenterInput, CollectionWordsUsecasePresentable {
    weak var view: CollectionWordsViewControllerInput?
    var usecase: CollectionWordsUsecaseInput?
    
    private var datasource: CollectionDatasource?
    private var dataSnapshot = NSDiffableDataSourceSnapshot<TableSection, Word>()

    private var indexPath: IndexPath?
    
    init(selected indexPath: IndexPath) {
        self.indexPath = indexPath
    }

    func cofigureUI(collectionView: UICollectionView) {
        datasource = CollectionDatasource(collectionView: collectionView)
        usecase?.getCollection()
        datasource?.apply(dataSnapshot)
    }
    
    func add(_ items: [Word]) {
        applySnapshot(&dataSnapshot, for: items, isRefreshing: false, completion: {
            DispatchQueue.main.async {
                if let indexPath = self.indexPath {
                    self.view?.scroll(to: indexPath, animated: false)
                    self.indexPath = nil
                }
            }
        })
    }
    
    private func applySnapshot(_ snapshot: inout NSDiffableDataSourceSnapshot<TableSection, Word>,
                               for items: [Word],
                               isRefreshing: Bool, completion: (() -> Void)? ) {
        
        if isRefreshing {
            snapshot.deleteAllItems()
        }
        
        if !snapshot.sectionIdentifiers.contains(.search) {
            snapshot.appendSections([.search])
        }
        
        snapshot.appendItems(items, toSection: .search)
        
        datasource?.apply(snapshot, animatingDifferences: true, completion: completion)
    }
}
