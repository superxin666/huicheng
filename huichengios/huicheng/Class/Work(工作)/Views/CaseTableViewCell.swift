//
//  CaseTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/4/12.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let CaseTableViewCellId = "CaseTableViewCell_id"
let CaseTableViewCellH = CGFloat(80)

class CaseTableViewCell: UITableViewCell {
    @IBOutlet weak var titleNameLabel: UILabel!

    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!

    @IBOutlet weak var nameLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(model : checkcaseModel)  {
        if let title = model.name {
            self.titleNameLabel.text = title
        }
        if let time = model.regtime {
            self.timeLabel.text = String.hc_getDate_string(dateStr: time)
        }
        if let type = model.type {
            self.typeLabel.text = type
        }
        if let reguser = model.reguser {
            self.nameLabel.text = reguser
        }
    }


    /// 合同管理  合同审核
    ///
    /// - Parameter model: <#model description#>
    func setData_deal(model :dealGetlistModel) {
        self.subLabel.isHidden = false
        if let dealsnum = model.dealsnum {
            self.titleNameLabel.text = dealsnum
        }
        if let time = model.regtime {
            self.timeLabel.text = String.hc_getDate_string(dateStr: time)
        }
        if let type = model.type {
            self.typeLabel.text = type
        }
        if let stateStr = model.stateStr {
            self.nameLabel.text = stateStr
        }
        if let reguser = model.reguser {
            self.subLabel.text = reguser

        }
        if let state = model.state {
           self.nameLabel.backgroundColor = darkblueColor
           self.nameLabel.textColor = .white
        }

    }

    func setData_invoice(model : invoice_getlistModel) {
        self.subLabel.isHidden = false
        if let titlesStr = model.titlesStr {
            self.titleNameLabel.text = titlesStr
        }
        if let money = model.money {
            self.subLabel.text = "\(money)"
        }
        if let time = model.addtime {
            self.timeLabel.text = String.hc_getDate_string(dateStr: time)
        }
        
        if let user = model.user {
            self.typeLabel.text = user
        }
        if let state = model.state {
            self.nameLabel.backgroundColor = darkblueColor
            self.nameLabel.textColor = .white
        }
    }
    
}
