//
//  StatisticsTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/9/18.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let StatisticsTableViewCellH = CGFloat(140)
let StatisticsTableViewCellID = "StatisticsTableViewCell_id"

class StatisticsTableViewCell: UITableViewCell {
    @IBOutlet weak var left1: UILabel!

    @IBOutlet weak var left2: UILabel!

    @IBOutlet weak var left3: UILabel!


    @IBOutlet weak var left4: UILabel!


    @IBOutlet weak var left5: UILabel!

    @IBOutlet weak var left6: UILabel!
    @IBOutlet weak var right1: UILabel!

    @IBOutlet weak var right2: UILabel!
    
    @IBOutlet weak var right3: UILabel!
    
    @IBOutlet weak var right4: UILabel!
    @IBOutlet weak var right5: UILabel!

    @IBOutlet weak var right6: UILabel!
    

    func setData(model : income_getcountModel) {
//        let strName =  model.name.getAttributedStr_color(color: darkblueColor, fontSzie: 12)

        let strName = NSMutableAttributedString(string: model.name)
        let strName2 = "(账号：\(model.username))".getAttributedStr_color(color: UIColor.hc_colorFromRGB(rgbValue: 0x333333), fontSzie: 10)
        strName.append(strName2)

        self.left1.attributedText = strName



        self.left2.text = "委托人：" + model.principal
        self.left3.text = model.type

        let str = NSMutableAttributedString(string: "转账手续费：")
        let str1 = "\(model.cost!)元".getAttributedStr_color(color: orangeColor, fontSzie: 12)
        str.append(str1)
        self.left4.attributedText = str

        let str2 = NSMutableAttributedString(string: "收款金额：")
        let str3 = "\(model.money!)元".getAttributedStr_color(color: orangeColor, fontSzie: 12)
        str2.append(str3)
        self.left5.attributedText =  str2



        self.left6.text = String.hc_getDate_style1(dateStr: model.addtime, style: 4)


        self.right1.text = model.dealnum
        self.right2.text = model.papernum
        self.right3.text = model.invoicetype


        let str4 = NSMutableAttributedString(string: "提取金额：")
        let str5 = "\(model.pick!)元".getAttributedStr_color(color: orangeColor, fontSzie: 12)
        str4.append(str5)
        self.right4.attributedText = str4




        let str6 = NSMutableAttributedString(string: "余额：")
        let str7 = "\(model.balance!)元".getAttributedStr_color(color: orangeColor, fontSzie: 12)
        str6.append(str7)
        self.right5.attributedText = str6



        if model.state.count > 0 {
            self.right6.backgroundColor = UIColor.hc_colorFromRGB(rgbValue: 0xcccccc)
            self.right6.text = model.state
        } else {
            self.right6.text = "未支付"
            self.right6.backgroundColor = darkblueColor

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
