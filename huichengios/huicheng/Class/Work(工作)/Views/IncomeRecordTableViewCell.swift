//
//  IncomeRecordTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/8/29.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let IncomeRecordTableViewCellH = CGFloat(120)
let IncomeRecordTableViewCellID = "IncomeRecordTableViewCell_ID"



class IncomeRecordTableViewCell: UITableViewCell {
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    
    @IBOutlet weak var titleNameLabel: UILabel!



    func setData_add(model : Income_getlistModel) {
        var amount = ""

        if let amountInt = model.amountInt {
            amount = "\(amountInt)"
        }
        self.titleNameLabel.text = "收款详情：" + model.typeStr! + "：\(amount)"

        self.subLabel.text = "收款日期：\(model.addtime!)   登记人：\(model.user!)"

        self.infoLabel.text = "发票信息："

        if let stateStr = model.stateStr {
            self.stateLabel.text = stateStr
        }


        if let state = model.state {
            if state == 0 {
                self.stateLabel.backgroundColor = darkblueColor
                self.stateLabel.textColor = .white

            }else if state == 1 {
                self.stateLabel.backgroundColor = UIColor.hc_colorFromRGB(rgbValue: 0xcccccc)
                self.stateLabel.textColor = .white


            } else if state == 2 {
                self.stateLabel.backgroundColor = orangeColor
                self.stateLabel.textColor = .white

            } else if state == 3 {
                self.stateLabel.hc_makeBorderWithBorderWidth(width: 1, color: UIColor.hc_colorFromRGB(rgbValue: 0x999999))
                self.stateLabel.backgroundColor = .white
                self.stateLabel.textColor = UIColor.hc_colorFromRGB(rgbValue: 0x999999)

            } else {
                self.stateLabel.backgroundColor = darkblueColor
                self.stateLabel.textColor = .white
            }
        }


    }


    func setData_history(model : Income_getlistModel) {



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
