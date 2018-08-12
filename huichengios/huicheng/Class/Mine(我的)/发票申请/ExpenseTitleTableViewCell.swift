//
//  ExpenseTitleTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/8/12.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let ExpenseTitleTableViewCellH = ip6(50)
let ExpenseTitleTableViewCellID = "ExpenseTitleTableViewCell_id"

class ExpenseTitleTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //标题
        self.titleLabel.text = "1、发票的付款单位为：北京市惠诚律师事务所，不得简写。\n2、发票必须为当年的票据"

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
