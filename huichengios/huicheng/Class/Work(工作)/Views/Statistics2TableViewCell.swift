//
//  Statistics2TableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/9/19.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let Statistics2TableViewCellH = CGFloat(80)
let Statistics2TableViewCellID = "Statistics2TableViewCell_id"

class Statistics2TableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var left1: UILabel!
    
    @IBOutlet weak var left2: UILabel!
    @IBOutlet weak var right1: UILabel!
    @IBOutlet weak var right2: UILabel!


    func setData(model : income_getcountModel){

        self.titleLabel.text = model.name


        let str = NSMutableAttributedString(string: "转账手续费：")
        let str1 = "\(model.cost!)元".getAttributedStr_color(color: orangeColor, fontSzie: 12)
        str.append(str1)
        self.left1.attributedText = str


        let str2 = NSMutableAttributedString(string: "提取金额：")
        let str3 = "\(model.pick!)元".getAttributedStr_color(color: orangeColor, fontSzie: 12)
        str2.append(str3)
        self.left2.attributedText =  str2


        let str4 = NSMutableAttributedString(string: "收款金额：")
        let str5 = "\(model.money!)元".getAttributedStr_color(color: orangeColor, fontSzie: 12)
        str4.append(str5)
        self.right1.attributedText =  str4

        let str6 = NSMutableAttributedString(string: "余额：")
        let str7 = "\(model.balance!)元".getAttributedStr_color(color: orangeColor, fontSzie: 12)
        str6.append(str7)

        self.right2.attributedText = str6

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
