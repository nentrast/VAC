//
//  ProfileView.swift
//  Vocabrurary
//
//  Created by Alexandr Lobanov on 29.06.2020.
//  Copyright © 2020 Alexandr Lobanov. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func updateUsernameLabel(with text: String) {
        usernameLabel.text = text
    }
}


fileprivate extension ProfileView {
    func setupUI() {
        self.addSubview(usernameLabel)
        
        NSLayoutConstraint.activate([
            usernameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}

