//
//  UIAlertController+.swift
//  btr-label
//
//  Created by Kentarou on 2018/05/24.
//  Copyright © 2018年 西川継延. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    
    // テキストフィール付き２つボタンのアラートを生成
    static func textFieldAlert(title   : String? = nil,
                               message : String? = nil,
                               button1Title : String? = nil,
                               button2Title : String? = nil,
                               textFieldPlaceholder: String? = nil,
                               handler1: @escaping () -> (),
                               handler2: @escaping ([UITextField]?) -> ()) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: button1Title, style: .default, handler: { action in
            handler1()
        })
        
        let action2 = UIAlertAction(title: button2Title, style: .default, handler: { action in
            handler2(alert.textFields)
        })
        
        alert.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
            textField.placeholder = textFieldPlaceholder
        })
        
        alert.addAction(action1)
        alert.addAction(action2)
        return alert
    }
    
    
    static func twoButtonAlert(title   : String? = nil,
                               message : String? = nil,
                               button1Title : String? = nil,
                               button2Title : String? = nil,
                               handler1: @escaping () -> (),
                               handler2: @escaping () -> ()) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: button1Title, style: .default, handler: { action in
            handler1()
        })
        
        let action2 = UIAlertAction(title: button2Title, style: .default, handler: { action in
            handler2()
        })
        
        alert.addAction(action1)
        alert.addAction(action2)
        return alert
    }
}
