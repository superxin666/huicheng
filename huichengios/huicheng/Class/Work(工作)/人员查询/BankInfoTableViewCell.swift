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

    func setData3(model : usermanageInfoModel_info3) {
        let strName = NSMutableAttributedString(string: "办公软件：")
        let strName1 = model.office.getAttributedStr_color(color: .black, fontSzie: 13)
        strName.append(strName1)
        self.label1.attributedText = strName

        let strName2 = NSMutableAttributedString(string: "打字速度：")
        let strName3 = model.printspeed.getAttributedStr_color(color: .black, fontSzie: 13)
        strName2.append(strName3)
        self.label2.attributedText = strName2

        self.label3.text = ""

    }

    func setData4(model : usermanageInfoModel_info3_train) {
        let strName = NSMutableAttributedString(string: "时间：")
        let str = String.hc_getDate_style1(dateStr: model.begintime, style: 4) +  String.hc_getDate_style1(dateStr: model.endtime, style: 4)
        let strName1 = str.getAttributedStr_color(color: .black, fontSzie: 13)
        strName.append(strName1)
        self.label1.attributedText = strName

        let strName2 = NSMutableAttributedString(string: "培训内容：")
        let strName3 = model.content.getAttributedStr_color(color: .black, fontSzie: 13)
        strName2.append(strName3)
        self.label2.attributedText = strName2

        let strName4 = NSMutableAttributedString(string: "证书：")
        let strName5 = model.paper.getAttributedStr_color(color: .black, fontSzie: 13)
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
