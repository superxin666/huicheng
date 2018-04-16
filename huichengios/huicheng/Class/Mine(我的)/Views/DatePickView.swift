//
//  DatePickView.swift
//  huicheng
//
//  Created by lvxin on 2018/4/1.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
protocol DatePickViewDelegate {
    func datePickViewTime(timeStr : String,type : Int)
}

class DatePickView: UIView,NibLoadable {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var timeStr : String = String.getDateNow()
    var delegate : DatePickViewDelegate!
    
    /// 0 是开始时间 1是结束时间 默认为0
    var typeNum : Int = 0
    
    
    @IBAction func timeChange(_ sender: UIDatePicker) {
        
        HCLog(message: sender.date)
        let str = String.hc_getDate(date: sender.date)
        HCLog(message: str)
        timeStr = str

    }
    @IBAction func sureClick(_ sender: UIButton) {
        if let delegate = self.delegate {
            delegate.datePickViewTime(timeStr: timeStr,type: typeNum)
        }
        self.removeFromSuperview()
    }
    
    func setData(type : Int)  {
        typeNum = type
        
    }
    
}
