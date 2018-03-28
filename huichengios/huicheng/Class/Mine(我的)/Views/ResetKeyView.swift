//
//  ResetKeyView.swift
//  huicheng
//
//  Created by lvxin on 2018/3/24.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit

class ResetKeyView: UIView,NibLoadable {
    var oldkey : String!
    var newkey : String!
    var surekey :String!
    
    @IBOutlet weak var sureTextField: UITextField!
    
    @IBOutlet weak var oldTextField: UITextField!
    
    @IBOutlet weak var newTextField: UITextField!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBAction func endText(_ sender: UITextField) {
        
        if let text = sender.text {
            if sender.tag == 0 {
                oldkey = text
            } else if sender.tag == 1 {
                newkey = text
            } else {
                surekey = text
            }

        }
        HCLog(message: sender.text)
    }
    
}
