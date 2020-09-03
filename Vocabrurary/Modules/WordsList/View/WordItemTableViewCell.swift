//
//  WordItemTableViewCell.swift
//  Vocabrurary
//
//  Created by Alexandr Lobanov on 29.06.2020.
//  Copyright © 2020 Alexandr Lobanov. All rights reserved.
//

import UIKit

protocol WordItemTableViewCellDelegate: class {
 func cell(_ cell: UITableViewCell, showCollection button: UIButton)
    func cell(_ cell: UITableViewCell, playSoundPressed button: UIButton)
}

class WordItemTableViewCell: UITableViewCell {
    @IBOutlet weak var playSoundButton: UIButton!
    @IBOutlet weak var originalTextLabel: UILabel!
    @IBOutlet weak var translateLabel: UILabel!
    @IBOutlet weak var collectionButton: UIButton!
    @IBOutlet weak var assosiatedImageView: UIImageView!
    
    weak var delegate: WordItemTableViewCellDelegate?

    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Configure
    
    func configure(model: Word) {
        originalTextLabel.text = model.original
        translateLabel.text = model.translate
        collectionButton.setTitle(model.collection?.name, for: .normal)
        assosiatedImageView.image = UIImage(data: model.image ?? Data())
    }
    
    
    // MARK: - Actions
    
    @IBAction func playSoundAction(_ sender: UIButton) {
        delegate?.cell(self, playSoundPressed: sender)
    }
    
    @IBAction func showCollection(_ sender: UIButton) {
        delegate?.cell(self, showCollection: sender)
    }
}
