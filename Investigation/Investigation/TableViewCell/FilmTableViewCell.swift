//
//  TableViewCell.swift
//  Investigation
//
//  Created by Ivana Lubar on 08/07/2020.
//  Copyright © 2020 Ivana Lubar. All rights reserved.
//

import UIKit

class FilmTableViewCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!

     func configure(with item: Film) {
        titleLabel.text = item.title
    }

    func configure(with string: String) {
         titleLabel.text = string
    }
}
