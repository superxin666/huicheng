//
//  StartTimeTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/4/2.
//  Copyright © 2018年 lvxin. All rights reserved.
//  开始时间

import UIKit

class StartTimeTableViewCell: UITableViewCell {
    @IBOutlet weak var titleNameLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
