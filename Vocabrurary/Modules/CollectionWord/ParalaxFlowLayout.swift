//
//  ParalaxFlowLayout.swift
//  ParalaxCollectionView
//
//  Created by Alexandr Lobanov on 5/29/19.
//  Copyright © 2019 Alexandr Lobanov. All rights reserved.
//
import UIKit

class ParallaxCollectionViewLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        scrollDirection = .horizontal
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        scrollDirection = .horizontal
        minimumInteritemSpacing = 5
        minimumLineSpacing = 5
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return super.layoutAttributesForElements(in: rect)?.compactMap { $0.copy() as? UICollectionViewLayoutAttributes }.compactMap(addParallaxToAttributes)
    }
    
    override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    private func addParallaxToAttributes(_ attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        guard let collectionView = self.collectionView else { return attributes }
        
        let width = collectionView.frame.width
        let centerX = width / 2
        let offset = collectionView.contentOffset.x
        let itemX = attributes.center.x - offset
        let position = (itemX - centerX) / width
        let cell = collectionView.cellForItem(at: attributes.indexPath) //as? PictureCollectionViewCell
        
//        let contentView = cell?.pictureImageView
        
//        if abs(position) >= 1 {
//            contentView?.transform = .identity
//        } else {
//            let transitionX = -(width * 0.5 * position)
//            contentView?.transform = CGAffineTransform(translationX: transitionX, y: 0)
//        }
        
        return attributes
    }
}
