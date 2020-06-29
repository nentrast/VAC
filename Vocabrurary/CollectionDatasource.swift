//
//  CollectionDatasource.swift
//  Vocabrurary
//
//  Created by Alexandr Lobanov on 02.06.2020.
//  Copyright © 2020 Alexandr Lobanov. All rights reserved.
//

import UIKit

class CollectionDatasource: UICollectionViewDiffableDataSource<TableSection, Word> {
    
    init(collectionView: UICollectionView) {
        super.init(collectionView: collectionView) { (collectionView, indexPath, model) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CardCollectionViewCell.self), for: indexPath) as? CardCollectionViewCell
            cell?.configure(model: model)
            return cell
        }
    }
}


