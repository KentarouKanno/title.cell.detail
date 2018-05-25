//
//  CellData.swift
//  btr-label
//
//  Created by Kentarou on 2018/05/24.
//  Copyright © 2018年 西川継延. All rights reserved.
//

import Foundation

class CellData {
    var title: String = ""
    var details: [String] = []
    
    init(_ title: String) {
        self.title = title
    }
    
    func append(detailText: String) {
        details.append(detailText)
    }
}
