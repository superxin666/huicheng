//
//  MemoTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/3/22.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit

class MemoTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var noticeImagView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.stateLabel.hc_makeRadius(radius: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(model : memo_getlistModel)  {
        if let title = model.content {
            self.titleLabel.text = title
        }
        if let time = model.remindtime {
            self.timeLabel.text = time
        }
        if let stateStr = model.stateStr {
            self.stateLabel.text = stateStr
        }
        if let state = model.state {
            if state == 1{
                self.stateLabel.backgroundColor = UIColor.hc_ColorFromInt(red: 204, green: 204, blue: 204, alpha: 1.0)
            } else {
                self.stateLabel.backgroundColor = darkblueColor
            }
        }
        
    }
    
}
