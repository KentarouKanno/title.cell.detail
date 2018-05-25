//
//  TitleCell.swift
//  btr-label
//
//  Created by Kentarou on 2018/05/24.
//  Copyright © 2018年 西川継延. All rights reserved.
//

import UIKit

class TitleCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    var cellData: CellData? {
        didSet {
            if let cellData = cellData {
                titleLabel.text = cellData.title
            }
        }
    }
}
