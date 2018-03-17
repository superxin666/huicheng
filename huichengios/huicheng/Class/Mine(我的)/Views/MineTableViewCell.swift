//
//  MineTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/3/18.
//  Copyright © 2018年 lvxin. All rights reserved.
//  我的 cell

import UIKit

class MineTableViewCell: UITableViewCell {
    let nameArr = ["备忘录","报销申请","发票申请","发票申请","发票申请",]
    @IBOutlet weak var titleLabel: UILabel!
    
    /// 标题
    var titleStr : String!
    
    func setData(index : Int)  {
        self.titleLabel.text = nameArr[index]
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
