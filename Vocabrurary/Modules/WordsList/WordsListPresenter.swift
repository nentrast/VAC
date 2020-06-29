//
//  WordsListPresenter.swift
//  Vocabrurary
//
//  Created by Alexandr Lobanov on 01.06.2020.
//  Copyright © 2020 Alexandr Lobanov. All rights reserved.
//

import UIKit

protocol WordsListPresenterInput: class {
    var interactor: Interactor { get }
    
    func configure(tableView: UITableView)
    func didSelectItem(at indexPath: IndexPath)
    func removeItem(at indexPath: IndexPath)
}

protocol WordsListUsecasePresentable: class {
    func add(_ items: [Word])
}

enum TableSection: CaseIterable {
    case main
    case search
}

class WordsListPresenter: WordsListPresenterInput, WordsListUsecasePresentable {
    weak var view: WordsListViewControllerInput?
    var usecase: WordsListUsecaseProtocol?
    
    var interactor: Interactor  = Interactor()

    private var datasource: TableviewDatasource?
    private var searchSnapshot = NSDiffableDataSourceSnapshot<TableSection, Word>()
    private var dataSnapshot = NSDiffableDataSourceSnapshot<TableSection, Word>()
    
    
    var emptyDataResultCompletion: ((Bool) -> Void)?
        
    func configure(tableView: UITableView) {
        view?.register(WordItemTableViewCell.self)
        usecase?.getListOfWords()
        
        datasource = TableviewDatasource(tableView: tableView, cellDelegate: self)
        
        datasource?.apply(dataSnapshot)
    }
    
    func removeItem(at indexPath: IndexPath) {
        guard let model =  datasource?.itemIdentifier(for: indexPath) else {
            return
        }
        usecase?.remove(item: model)
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        usecase?.showItem(at: indexPath, with: interactor)
    }
        
    func add(_ items: [Word]) {
        applySnapshot(&dataSnapshot, for: items, isRefreshing: false, emptyHanlder: emptyDataResultCompletion)
    }
    
    private func applySnapshot(_ snapshot: inout NSDiffableDataSourceSnapshot<TableSection, Word>,
                       for items: [Word],
                       isRefreshing: Bool,
                       emptyHanlder: ((Bool) -> Void)? = nil) {
        
        if isRefreshing {
            snapshot.deleteAllItems()
        }

        if !snapshot.sectionIdentifiers.contains(.search) {
            snapshot.appendSections([.search])
        }
        
        snapshot.appendItems(items, toSection: .search)
        
        datasource?.apply(snapshot, animatingDifferences: true, completion: nil)
        
        let isEmptyDatasource = datasource?.snapshot().itemIdentifiers.count == 0
        let isEmptySnapshot = snapshot.itemIdentifiers.count == 0
        
        emptyHanlder?(isEmptyDatasource && isEmptySnapshot)
    }

}

extension WordsListPresenter: WordItemTableViewCellDelegate {
    func cell(_ cell: UITableViewCell, showCollection button: UIButton) {
        guard let indexPath = view?.indexPath(for: cell), let model =  datasource?.itemIdentifier(for: indexPath) else {
            return
        }
        
        usecase?.showCollection(for: indexPath, model: model)
    }
    
    func cell(_ cell: UITableViewCell, playSoundPressed button: UIButton) {
        guard let indexPath = view?.indexPath(for: cell), let model =  datasource?.itemIdentifier(for: indexPath) else {
            return
        }
        
        usecase?.playSound(for: model)
    }
}
