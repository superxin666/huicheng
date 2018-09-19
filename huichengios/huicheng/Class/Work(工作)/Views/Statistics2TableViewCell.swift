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
        
        self.left1.text = "转账手续费：" + "\(model.cost!)"
        self.left2.text = "提取金额：" + "\(model.pick!)" + "元"

        self.right1.text = "收款金额：" + "\(model.money!)元"
        self.right2.text = "余额：" + "\(model.balance!)元"

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
