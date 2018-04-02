//
//  DatePickView.swift
//  huicheng
//
//  Created by lvxin on 2018/4/1.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit

class DatePickView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var timeStr : String = ""
    
    @IBAction func timeChange(_ sender: UIDatePicker) {
        
        
        HCLog(message: sender.date)
        let str = String.hc_getDate(date: sender.date)
        HCLog(message: str)
        timeStr = str
   
    }
    
}
