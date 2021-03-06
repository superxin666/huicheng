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
            self.titleNameLabel.textColor = darkblueColor
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


    func setData_searchCase(model : checkcaseModel)  {
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
    func setData_incomeHistory(model : getdetailModel_income) {
        self.subLabel.isHidden = false
        if let dealsnum = model.note {
            self.titleNameLabel.text = dealsnum
        }
        self.titleNameLabel.textColor = darkblueColor

        if let time = model.addtime {
            self.timeLabel.text = String.hc_getDate_string(dateStr: time)
        }

        if let user = model.user {
            self.typeLabel.text = user
        }

        if let stateStr = model.state {
            self.nameLabel.text = stateStr
        }
    }


    func setData_doclist(model : getdetailModel_document)  {

        self.subLabel.isHidden = false
        if let dealsnum = model.num {
            self.titleNameLabel.text = dealsnum
        }
        self.titleNameLabel.textColor = darkblueColor
        if let time = model.addtime {
            self.timeLabel.text = String.hc_getDate_string(dateStr: time)
        }
        if let type = model.type {
            self.typeLabel.text = type
        }
        if let stateStr = model.state {
            self.nameLabel.text = stateStr
        }
        if let reguser = model.user {
            self.subLabel.text = reguser

        }
        //                -1-未提交;0-未审核;1-已审核;2-审核驳回;3- 已结案
//        if let state = model.state {
//            if state == 0 {
//                self.nameLabel.backgroundColor = darkblueColor
//                self.nameLabel.textColor = .white
//
//            }else if state == 1 {
//                self.nameLabel.backgroundColor = UIColor.hc_colorFromRGB(rgbValue: 0xcccccc)
//                self.nameLabel.textColor = .white
//
//
//            } else if state == 2 {
//                self.nameLabel.backgroundColor = orangeColor
//                self.nameLabel.textColor = .white
//
//            } else if state == 3 {
//                self.nameLabel.hc_makeBorderWithBorderWidth(width: 1, color: UIColor.hc_colorFromRGB(rgbValue: 0x999999))
//                self.nameLabel.backgroundColor = .white
//                self.nameLabel.textColor = UIColor.hc_colorFromRGB(rgbValue: 0x999999)
//
//            } else if state == -1 {
//                self.nameLabel.hc_makeBorderWithBorderWidth(width: 1, color: darkblueColor)
//                self.nameLabel.backgroundColor = .white
//                self.nameLabel.textColor = darkblueColor
//
//            }
//        }

    }



    func setData_dealmanger(model :dealGetlistModel) {
        self.subLabel.isHidden = false
        if let dealsnum = model.dealsnum {
            self.titleNameLabel.text = dealsnum
        }
        self.titleNameLabel.textColor = darkblueColor
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
        //                -1-未提交;0-未审核;1-已审核;2-审核驳回;3- 已结案
        if let state = model.state {
            if state == 0 {
                self.nameLabel.backgroundColor = darkblueColor
                self.nameLabel.textColor = .white

            }else if state == 1 {
                self.nameLabel.backgroundColor = UIColor.hc_colorFromRGB(rgbValue: 0xcccccc)
                self.nameLabel.textColor = .white


            } else if state == 2 {
                self.nameLabel.backgroundColor = orangeColor
                self.nameLabel.textColor = .white

            } else if state == 3 {
                self.nameLabel.hc_makeBorderWithBorderWidth(width: 1, color: UIColor.hc_colorFromRGB(rgbValue: 0x999999))
                self.nameLabel.backgroundColor = .white
                self.nameLabel.textColor = UIColor.hc_colorFromRGB(rgbValue: 0x999999)

            } else if state == -1 {
                self.nameLabel.hc_makeBorderWithBorderWidth(width: 1, color: darkblueColor)
                self.nameLabel.backgroundColor = .white
                self.nameLabel.textColor = darkblueColor

            } else if state == 4 {
                self.nameLabel.backgroundColor = orangeColor
                self.nameLabel.textColor = .white

            }
        }


    }

    ///   合同审核 结案审核
    ///
    /// - Parameter model: <#model description#>
    func setData_deal(model :dealGetlistModel) {
        self.subLabel.isHidden = false
        if let dealsnum = model.dealsnum {
            self.titleNameLabel.text = dealsnum
        }
        self.titleNameLabel.textColor = darkblueColor
        if let time = model.regtime {
            self.timeLabel.text = String.hc_getDate_string(dateStr: time)
        }
        if let type = model.type {
            self.typeLabel.text = type
        }
//        if let stateStr = model.stateStr {
//            self.nameLabel.text = stateStr
//        }
        if let reguser = model.reguser {
            self.nameLabel.text = reguser

        }
//        -1-未提交;0-未审核;1-已审核;2-审核驳回;3- 已结案
//        if let state = model.state {
//            if state == 0 {
//                self.nameLabel.backgroundColor = darkblueColor
//                self.nameLabel.textColor = .white
//
//            }else if state == 1 {
//                self.nameLabel.backgroundColor = UIColor.hc_colorFromRGB(rgbValue: 0xcccccc)
//                self.nameLabel.textColor = .white
//
//
//            } else if state == 2 {
//                self.nameLabel.backgroundColor = orangeColor
//                self.nameLabel.textColor = .white
//
//            } else if state == 3 {
//                self.nameLabel.hc_makeBorderWithBorderWidth(width: 1, color: UIColor.hc_colorFromRGB(rgbValue: 0x999999))
//                self.nameLabel.backgroundColor = .white
//                self.nameLabel.textColor = UIColor.hc_colorFromRGB(rgbValue: 0x999999)
//
//            } else if state == -1 {
//                self.nameLabel.hc_makeBorderWithBorderWidth(width: 1, color: darkblueColor)
//                self.nameLabel.backgroundColor = .white
//                self.nameLabel.textColor = darkblueColor
//
//            }
//        }

    }

    func setData_invoice(model : invoice_getlistModel) {
        self.subLabel.isHidden = false
        if let titlesStr = model.titlesStr {
            self.titleNameLabel.text = titlesStr
        }
        if let money = model.money {
            self.subLabel.text = "\(money)元"
        }
        if let time = model.addtime {
            self.timeLabel.text = String.hc_getDate_string(dateStr: time)
        }
        
        if let user = model.user {
            self.typeLabel.text = user
        }
        if let stateStr = model.stateStr {
            self.nameLabel.text = stateStr

        }

        if let state = model.state {
            if state == 0 {
                self.nameLabel.backgroundColor = darkblueColor
                self.nameLabel.textColor = .white

            }else if state == 1 {
                self.nameLabel.backgroundColor = UIColor.hc_colorFromRGB(rgbValue: 0xcccccc)
                self.nameLabel.textColor = .white


            } else if state == 2 {
                self.nameLabel.backgroundColor = orangeColor
                self.nameLabel.textColor = .white

            } else if state == 3 {
                self.nameLabel.hc_makeBorderWithBorderWidth(width: 1, color: UIColor.hc_colorFromRGB(rgbValue: 0x999999))
                self.nameLabel.backgroundColor = .white
                self.nameLabel.textColor = UIColor.hc_colorFromRGB(rgbValue: 0x999999)

            }
        }

    }

    func setData_expense(model : expense_getlistModel) {
        self.subLabel.isHidden = false
        if let titlesStr = model.typeStr {
            self.titleNameLabel.text = titlesStr
        }
        if let money = model.money {
            self.subLabel.text = "\(money)元"
        }
        if let time = model.addtime {
            self.timeLabel.text = String.hc_getDate_string(dateStr: time)
        }

        if let user = model.user {
            self.typeLabel.text = user
        }
//


    }

    /// 银行信息
    ///
    /// - Parameter model: <#model description#>
    func setData_bank(model : bank_getlistModel) {
        self.typeLabel.isHidden = false
        self.subLabel.isHidden = false
        if let name = model.username {
            self.titleNameLabel.text = name
        }
        if let bankname = model.bankname {
            self.subLabel.text = bankname
        }
        if let card = model.bankcard {
            self.timeLabel.text = card
        }
        if let department = model.department {
            self.typeLabel.text = department
        }

        if let stateStr = model.stateStr {
            self.nameLabel.text = stateStr
        }
        if let state = model.state {
            self.nameLabel.backgroundColor = darkblueColor
            self.nameLabel.textColor = .white
            self.nameLabel.text = model.stateStr
        }

    }


    func setData_crt(model : CrtDealslistModel) {

      
        if let dealsnum = model.dealsnum {
            self.titleNameLabel.text = dealsnum
        }
        if let time = model.regtime {
            self.timeLabel.text = String.hc_getDate_string(dateStr: time)
        }
//        if let type = model.type {
//            self.typeLabel.text = type
//        }
//
//        if let stateStr = model.stateStr {
//            self.nameLabel.text = stateStr
//        }
        if let reguser = model.reguser {
            self.typeLabel.text = reguser

        }
//        if let state = model.state {
//            self.nameLabel.backgroundColor = darkblueColor
//            self.nameLabel.textColor = .white
//        }



    }
    
}
