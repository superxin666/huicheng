//
//  MessageTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/3/17.
//  Copyright © 2018年 lvxin. All rights reserved.
//  消息cell

import UIKit

class MessageTableViewCell: UITableViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(model : noticelistModel) {
        if let timeStr = model.createtime, let typeStr = model.type {
            timeLabel.text = "\(timeStr)|\(typeStr)"
        }
        if let titleStr = model.title {
            titleLabel.text = titleStr
        }
    }
    
}
