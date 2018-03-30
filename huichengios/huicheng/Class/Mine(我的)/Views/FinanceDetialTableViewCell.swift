//
//  FinanceDetialTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/3/30.
//  Copyright © 2018年 lvxin. All rights reserved.
//  收款详情cell

import UIKit

class FinanceDetialTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLbael: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(title :String,content:String) {
        self.titleLbael.text = title
        self.contentLabel.text = content
    }
    
}
