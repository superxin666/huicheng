//
//  DealinfoTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/10/21.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let DealinfoTableViewCellID = "DealinfoTableViewCell_id"
let DealinfoTableViewCellH = CGFloat(120)


class DealinfoTableViewCell: UITableViewCell {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!

    @IBOutlet weak var label3: UILabel!


    @IBOutlet weak var label4: UILabel!


    @IBOutlet weak var label5: UILabel!


    func setData(model : usermanageInfoModel_info6) {
        let strName = NSMutableAttributedString(string: "时间：")
        let str = model.begintime + "~" + model.endtime
        let strName1 = str.getAttributedStr_color(color: .black, fontSzie: 13)
        strName.append(strName1)
        self.label1.attributedText = strName

        let strName2 = NSMutableAttributedString(string: "合同类型：")
        let strName3 = model.type.getAttributedStr_color(color: .black, fontSzie: 13)
        strName2.append(strName3)
        self.label2.attributedText = strName2


        let strName4 = NSMutableAttributedString(string: "提成比例：")
        let strName5 = "\(model.proportion!)".getAttributedStr_color(color: .black, fontSzie: 13)
        strName4.append(strName5)
        self.label3.attributedText = strName4

        let strName6 = NSMutableAttributedString(string: "薪酬：")
        let strName7 = "\(model.salary!)元".getAttributedStr_color(color: .black, fontSzie: 13)
        strName6.append(strName7)
        self.label4.attributedText = strName6
        self.label5.text = "合同附件：查看"
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
