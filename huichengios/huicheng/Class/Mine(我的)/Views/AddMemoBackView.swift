//
//  AddMemoBackView.swift
//  huicheng
//
//  Created by lvxin on 2018/3/27.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit

class AddMemoBackView: UIView,NibLoadable,UITextViewDelegate {
    
    /// 是否提醒 默认不开 0不开1开
    var isNotice : Int = 0
    
    /// 备忘内容
    var noticeStr : String!
    
    /// 时间
    var timeStr : String!
    
    
    @IBOutlet weak var `switch`: UISwitch!
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func noticeSwitch(_ sender: UISwitch) {
        
        HCLog(message: sender.isOn)
        if sender.isOn {
            isNotice = 0
        } else {
            isNotice = 1
        }
        
    }
    
    @IBOutlet weak var timeBackView: UIView!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    override func awakeFromNib() {
        self.textView.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(showTime))
        self.timeBackView.addGestureRecognizer(tap)
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        HCLog(message: textView.text)
        if let str = textView.text {
            self.noticeStr = str
        } else {
            self.noticeStr = ""
        }
    }
    @IBAction func datePickValueChanged(_ sender: UIDatePicker) {
        HCLog(message: sender.date)
        timeStr = String.hc_getDate(date: sender.date)
        HCLog(message: timeStr)
        self.timeLabel.text = timeStr
    }
    
    @objc func showTime() {
        if textView.isFirstResponder {
            textView.resignFirstResponder()
        }
        self.timePicker.isHidden = !self.timePicker.isHidden
        
    }
    
    
    /// 详情
    ///
    /// - Parameter model: <#model description#>
    func setData(model : memo_getinfoModel) {
        self.textView.text = model.content
        self.timeLabel.text = model.remindtime
        if model.isremind == 1 {
            self.switch.isOn = true
        } else {
            self.switch.isOn = false
        }
        
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
