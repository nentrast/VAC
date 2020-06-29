//
//  BaseTableViewProtocol.swift
//  Vocabrurary
//
//  Created by Alexandr Lobanov on 01.06.2020.
//  Copyright © 2020 Alexandr Lobanov. All rights reserved.
//

import UIKit

protocol BasetableViewProtocol: class {
    var tableView: UITableView! {  get }
    func register(_ cell: UITableViewCell.Type)
}

extension BasetableViewProtocol {
    func register(_ cell: UITableViewCell.Type) {
        let nib = UINib(nibName: String(describing: cell), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: String(describing: cell))
    }
    
    func indexPath(for cell: UITableViewCell) -> IndexPath? {
        return tableView.indexPath(for: cell)
    }
}
