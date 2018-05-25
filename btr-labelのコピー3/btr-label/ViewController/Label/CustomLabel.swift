//
//  CustomLabel.swift
//  btr-label
//
//  Created by Kentarou on 2018/05/24.
//  Copyright © 2018年 西川継延. All rights reserved.
//

import UIKit

protocol CustomLabelDelegate: class  {
    func longPress(detailIndex: Int)
    func doubleTap(detailIndex: Int)
}

class CustomLabel: UILabel {
    
    var delegate: CustomLabelDelegate?
    var index: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isUserInteractionEnabled = true
        let longGesture = UILongPressGestureRecognizer(target: self,
                                                       action: #selector(self.handleLongPress(gesture:)))
        
        longGesture.minimumPressDuration = 0.5
        self.addGestureRecognizer(longGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(self.handleDoubleTap(gesture:)))
        tapGesture.numberOfTapsRequired = 2
        self.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleLongPress(gesture : UILongPressGestureRecognizer!) {
        guard gesture.state == .ended else { return }
        delegate?.longPress(detailIndex: index)
    }
    
    @objc func handleDoubleTap(gesture : UILongPressGestureRecognizer!) {
        guard gesture.state == .ended else { return }
        delegate?.doubleTap(detailIndex: index)
    }
}
