//
//  ResetKeyView.swift
//  huicheng
//
//  Created by lvxin on 2018/3/24.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit

class ResetKeyView: UIView,NibLoadable {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBAction func endText(_ sender: UITextField) {
        if sender.tag == 0 {
            
        } else if sender.tag == 1 {
            
        } else {
            
        }
        HCLog(message: sender.text)
    }
    
}
