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
        self.left1.text = model.username
        self.left2.text = "委托人：" + model.principal
        self.left3.text = model.type
        self.left4.text = "转账手续费：" + "\(model.cost!)元"
        self.left5.text = "收款金额：" + "\(model.money!)元"
        self.left6.text = String.hc_getDate_style1(dateStr: model.addtime, style: 4)


        self.right1.text = model.dealnum
        self.right2.text = model.papernum
        self.right3.text = model.invoicetype
        self.right4.text = "提取金额：" + "\(model.pick!)" + "元"
        self.right5.text = "余额" + "\(model.balance!)元"
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
