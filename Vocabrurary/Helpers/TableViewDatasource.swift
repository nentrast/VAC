//
//  TableViewDatasource.swift
//  Vocabrurary
//
//  Created by Alexandr Lobanov on 03.06.2020.
//  Copyright © 2020 Alexandr Lobanov. All rights reserved.
//

import UIKit

class TableviewDatasource: UITableViewDiffableDataSource<TableSection, Word> {
    
    init(tableView: UITableView, cellDelegate: WordItemTableViewCellDelegate) {
        super.init(tableView: tableView) {[weak cellDelegate] (tableView, indexPath, model) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WordItemTableViewCell.self), for: indexPath) as? WordItemTableViewCell
            cell?.configure(model: model)
            cell?.delegate = cellDelegate
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
