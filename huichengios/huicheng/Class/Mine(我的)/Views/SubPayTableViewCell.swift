//
//  SubPayTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/3/18.
//  Copyright © 2018年 lvxin. All rights reserved.
//  报销申请

import UIKit

class SubPayTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(model  :expense_getlistModel) {
        if let type = model.type ,let money = model.money {
            self.titleLabel.text = "\(type) \(money)元 "
            
        }
        if let total = model.total {
            self.subLabel.text = "共\(total)张附件"
            
        }

        if let time = model.addtime {
            self.timeLabel.text = time
            
        }
        if let state = model.stateStr {
            self.stateLabel.text = state
            
        }


    }
    
}
