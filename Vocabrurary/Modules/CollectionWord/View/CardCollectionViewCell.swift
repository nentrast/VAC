//
//  CardCollectionViewCell.swift
//  Vocabrurary
//
//  Created by Alexandr Lobanov on 01.06.2020.
//  Copyright © 2020 Alexandr Lobanov. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var addTranslateButton: UIButton!
    @IBOutlet weak var progressView: CircularProgressView!
    @IBOutlet weak var translatedWordLabel: UILabel!
    @IBOutlet weak var translatedWordButton: UIButton!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var previewImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupShadow(offset: 2, radius: 5, opacity: 0.3)
    }
    
    func configure(model: Word) {
        wordLabel.text = model.original
        translatedWordLabel.text  = model.translate
        progressView.setProgress(model.progress, animated: false)
    }

    func setupShadow(offset: CGFloat = 2, radius: CGFloat = 5, opacity: CGFloat = 0.2) {
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: offset, height: offset)
        layer.shadowRadius = radius
        layer.shadowOpacity = Float(opacity)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        progressView.setProgress(0, animated: false)
    }
    
    // MARK: - Action
    
    @IBAction func remove(_ sender: UIButton) {
        
    }
    
    @IBAction func pronounce(_ sender: UIButton) {
        
    }
    
    @IBAction func addAlternativeTranslate(_ sender: UIButton) {
        
    }
}
