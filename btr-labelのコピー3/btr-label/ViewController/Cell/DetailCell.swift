//
//  DetailCell.swift
//  btr-label
//
//  Created by Kentarou on 2018/05/24.
//  Copyright © 2018年 西川継延. All rights reserved.
//

import UIKit

protocol DetailCellDelegate: class {
    func tableReloadData()
    func editDetailText(index: Int, detailIndex: Int)
}

class DetailCell: UITableViewCell, CustomLabelDelegate  {
    
    weak var delegate: DetailCellDelegate?
    private let labelMargin: CGFloat = 10
    var index: Int = 0

    var cellData: CellData? {
        didSet {
            if let _ = cellData {
                upDateLabel()
            }
        }
    }
    
    func upDateLabel() {
        for label in contentView.subviews {
            label.removeFromSuperview()
        }
        var originX: CGFloat = 0
        guard let details = cellData?.details else { return }
        for item in details.enumerated()  {
            let label = CustomLabel()
            label.text = item.element
            label.sizeToFit()
            label.delegate = self
            label.index = item.offset
            label.textAlignment = .center
            label.frame = CGRect(x: originX, y: 0, width: label.frame.width + labelMargin * 2, height: 40)
            contentView.addSubview(label)
            originX = label.frame.maxX
        }
    }
    
    func longPress(detailIndex: Int) {
        cellData?.details.remove(at: detailIndex)
        delegate?.tableReloadData()
    }
    func doubleTap(detailIndex: Int) {
        delegate?.editDetailText(index: index, detailIndex: detailIndex)
    }
}
