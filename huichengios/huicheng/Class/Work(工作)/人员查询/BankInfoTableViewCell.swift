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
        let str = model.begintime + "~" + model.endtime
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

    func setData5(model : usermanageInfoModel_info4) {
        let strName = NSMutableAttributedString(string: "类型：")
        let strName1 = model.type.getAttributedStr_color(color: .black, fontSzie: 13)
        strName.append(strName1)
        self.label1.attributedText = strName

        let strName2 = NSMutableAttributedString(string: "内容：")
        let strName3 = model.content.getAttributedStr_color(color: .black, fontSzie: 13)
        strName2.append(strName3)
        self.label2.attributedText = strName2

        let strName4 = NSMutableAttributedString(string: "时间：")
        let strName5 = model.addtime.getAttributedStr_color(color: .black, fontSzie: 13)
        strName4.append(strName5)
        self.label3.attributedText = strName4
    }

    func setData6(model : usermanageInfoModel_info5) {
        let strName = NSMutableAttributedString(string: "缴费基数：")
        let strName1 = "\(model.insurance_basemoney)".getAttributedStr_color(color: .black, fontSzie: 13)
        strName.append(strName1)
        self.label1.attributedText = strName

        let strName2 = NSMutableAttributedString(string: "缴费日期：")
        let strName3 = model.insurance_starttime.getAttributedStr_color(color: .black, fontSzie: 13)
        strName2.append(strName3)
        self.label2.attributedText = strName2

        let strName4 = NSMutableAttributedString(string: "停缴日期：")
        let strName5 = model.insurance_endtime.getAttributedStr_color(color: .black, fontSzie: 13)
        strName4.append(strName5)
        self.label3.attributedText = strName4
    }

    func setData7(model : usermanageInfoModel_info5) {
        let strName = NSMutableAttributedString(string: "缴费基数：")
        let strName1 = "\(model.fund_basemoney)".getAttributedStr_color(color: .black, fontSzie: 13)
        strName.append(strName1)
        self.label1.attributedText = strName

        let strName2 = NSMutableAttributedString(string: "缴费日期：")
        let strName3 = model.fund_starttime.getAttributedStr_color(color: .black, fontSzie: 13)
        strName2.append(strName3)
        self.label2.attributedText = strName2

        let strName4 = NSMutableAttributedString(string: "停缴日期：")
        let strName5 = model.fund_endtime.getAttributedStr_color(color: .black, fontSzie: 13)
        strName4.append(strName5)
        self.label3.attributedText = strName4
    }

    func setData8(model : usermanageInfoModel_info7) {
        let strName = NSMutableAttributedString(string: "名称：")
        let strName1 = model.name.getAttributedStr_color(color: .black, fontSzie: 13)
        strName.append(strName1)
        self.label1.attributedText = strName

        let strName2 = NSMutableAttributedString(string: "上传时间：")
        let strName3 = model.addtime.getAttributedStr_color(color: .black, fontSzie: 13)
        strName2.append(strName3)
        self.label2.attributedText = strName2

        self.label3.text = "附件：查看"
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
