//
//  SubPayTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/3/18.
//  Copyright © 2018年 lvxin. All rights reserved.
//  报销申请

import UIKit

class SubPayTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.stateLabel.hc_makeRadius(radius: 1)
    }
    func setData(model  :expense_getlistModel) {
     
        if let typeStr = model.type ,let money = model.money {
            self.titleLabel.text = "\(typeStr) \(money)元 "
            
        }
        if let total = model.total {
            self.subLabel.text = "共\(total)张附件"
            
        }

        if let time = model.addtime {
            self.timeLabel.text = time
            
        }
        if let stateStr = model.stateStr {
            self.stateLabel.text = stateStr
        }
        if let state = model.state {
            if state == 0 {
                self.stateLabel.backgroundColor = darkblueColor
            } else if state == 1 {
                self.stateLabel.backgroundColor = UIColor.hc_colorFromRGB(rgbValue: 0x999999)
            } else {
                self.stateLabel.backgroundColor = orangeColor
            }
        }


    }
    
    func setData_finance(model : finance_getlistModel) {
        if let type = model.typeStr ,let money = model.money {
            self.titleLabel.text = "\(type) \(money)元 "
            
        }
        if let num = model.num {
            self.subLabel.text = num
            
        }
        
        if let time = model.addtime {
            self.timeLabel.text = time
            
        }
        if let stateStr = model.stateStr {
            HCLog(message: stateStr)
            self.stateLabel.text = stateStr
        }
        if let state = model.state{
            if state == 3 {
                self.stateLabel.backgroundColor = UIColor.hc_ColorFromInt(red: 204, green: 204, blue: 204, alpha: 1)
            } else {
                self.stateLabel.backgroundColor = darkblueColor
            }
        }
    }
    
}
