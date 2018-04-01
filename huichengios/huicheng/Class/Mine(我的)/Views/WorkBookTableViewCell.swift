//
//  WorkBookTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/3/22.
//  Copyright © 2018年 lvxin. All rights reserved.
//  工作日志列表

import UIKit
let workbookcellHeight = CGFloat(80)
let workbookcellid = "workbookcel_id"

class WorkBookTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var statsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.statsLabel.hc_makeRadius(radius: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected statese
    
    }
    
    func setData(model : work_getlistModel)  {
        if let title = model.title {
            self.titleLabel.text = title
        }
        if let time = model.addtime {
            self.timeLabel.text = time
        }
        
    }
    
    func setData_checkcase(model : checkcaseModel)  {
        self.statsLabel.backgroundColor = .clear
        self.statsLabel.textColor = UIColor.hc_colorFromRGB(rgbValue: 0x666666)
        if let nameStr = model.name {
            self.titleLabel.text = nameStr
        }
        var timeStr = ""
        
        if let regtime = model.regtime {
            timeStr = regtime
        }
        if let workersNameStr = model.workersName {
            timeStr = timeStr + workersNameStr
        }
        self.timeLabel.text = timeStr
        
        if let workersNameStr = model.workersName {
            self.statsLabel.text = workersNameStr
        }
    }
    
}
