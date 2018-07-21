//
//  DocTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/5/15.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let DocTableViewCellID = "DocTableViewCell_id"
let DocTableViewCellH = CGFloat(100)


class DocTableViewCell: UITableViewCell {
    @IBOutlet weak var titleNameLabel: UILabel!

    @IBOutlet weak var subTitleLabel: UILabel!


    @IBOutlet weak var subNunLabel: UILabel!

    @IBOutlet weak var timeLabel: UILabel!

    @IBOutlet weak var typeLabel: UILabel!

    @IBOutlet weak var stateLabel: UILabel!
    
    func setData_doc(model : docgetlistModel) {
        if let docnum = model.docnum {
            self.titleNameLabel.text = docnum
        }
        if let doctypeStr = model.doctypeStr {
            self.subTitleLabel.text = doctypeStr
        }
        if let dealnum = model.dealnum {
            self.subNunLabel.text = dealnum
        }
        if let addtime = model.addtime {
            self.timeLabel.text = String.hc_getDate_string(dateStr: addtime)
        }
        if let typeStr = model.typeStr {
            self.typeLabel.text = typeStr
        }

        if let stateStr = model.stateStr {
            self.stateLabel.text = stateStr
        }
        if let state = model.state {

        }
    }

    func setData_incomeList(model : Income_getlistModel) {
        if let dealnum = model.dealnum {
            self.titleNameLabel.text = dealnum
        }
        if let principal = model.principal {
            self.subTitleLabel.text = principal
        }

        self.subNunLabel.isHidden = true

        if let addtime = model.addtime {
            self.timeLabel.text = String.hc_getDate_string(dateStr: addtime)
        }
        if let typeStr = model.typeStr {
            self.typeLabel.text = typeStr
        }

        if let stateStr = model.stateStr {
            self.stateLabel.text = stateStr
        }
        if let state = model.state {
            
        }
    }


    ///
    func setData_searchIncome(model : Income_getlistModel) {

        if let dealsnum = model.dealsnum {
            self.titleNameLabel.text = dealsnum
        }
        if let type = model.type {
            self.subTitleLabel.text = type
        }
        if let dealnum = model.dealnum {
            self.subNunLabel.text = dealnum
        }
        if let regtime = model.regtime {
            self.timeLabel.text = String.hc_getDate_string(dateStr: regtime)
        }
        if let reguser = model.reguser {
            self.typeLabel.text = reguser
        }

        if let stateStr = model.stateStr {
            self.stateLabel.text = stateStr
        }
        if let state = model.state {

        }

    }

    func setData_incomeHistory(model : Income_getlistModel) {
        if let amount = model.amount {
            self.titleNameLabel.text = "收款金额\(amount)         " + model.typeStr
        }
        //后台没给参数
        if let typeStr = model.typeStr {
            self.subTitleLabel.text = "交款人:\(typeStr)"
        }
        //后台没给参数
        if let principal = model.principal {
            self.subNunLabel.text = principal
        }

        if let addtime = model.addtime {
            self.timeLabel.text = String.hc_getDate_string(dateStr: addtime)
        }
        if let user = model.user {
            self.typeLabel.text = "登记人:\(user)"
        }

        if let stateStr = model.stateStr {
            self.stateLabel.text = stateStr
        }
        if let state = model.state {

        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
