//
//  BankInfoTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/10/21.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let BankInfoTableViewCellID = "BankInfoTableViewCell_id"
let BankInfoTableViewCellH = CGFloat(80)


class BankInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label1: UILabel!

    @IBOutlet weak var label2: UILabel!


    func setData(model : usermanageInfoModel_info2) {
        let strName = NSMutableAttributedString(string: "业务特长：")
        let strName1 = model.features.getAttributedStr_color(color: .black, fontSzie: 13)
        strName.append(strName1)
        self.label1.attributedText = strName

        let strName2 = NSMutableAttributedString(string: "资格证号码：")
        let strName3 = model.certificate.getAttributedStr_color(color: .black, fontSzie: 13)
        strName2.append(strName3)
        self.label2.attributedText = strName2

        let strName4 = NSMutableAttributedString(string: "背调信息：")
        let strName5 = model.background.getAttributedStr_color(color: .black, fontSzie: 13)
        strName4.append(strName5)
        self.label3.attributedText = strName4
    }

    func setData2(model : usermanageInfoModel_info2) {
        let strName = NSMutableAttributedString(string: "支行：")
        let strName1 = model.subbranch.getAttributedStr_color(color: .black, fontSzie: 13)
        strName.append(strName1)
        self.label1.attributedText = strName

        let strName2 = NSMutableAttributedString(string: "卡号：")
        let strName3 = model.bankcard.getAttributedStr_color(color: .black, fontSzie: 13)
        strName2.append(strName3)
        self.label2.attributedText = strName2

        let strName4 = NSMutableAttributedString(string: "户名：")
        let strName5 = model.bankname.getAttributedStr_color(color: .black, fontSzie: 13)
        strName4.append(strName5)
        self.label3.attributedText = strName4
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
