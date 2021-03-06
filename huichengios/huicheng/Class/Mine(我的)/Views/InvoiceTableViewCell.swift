//
//  InvoiceTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/3/26.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit

class InvoiceTableViewCell: UITableViewCell {
    @IBOutlet weak var stteLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func setData(model : invoice_getlistModel) {

        if let type = model.type , let money = model.money {
            self.titleLabel.text = "\(type) \(money)"
        }
        if let titleStr = model.titlesStr {
            self.subLabel.text = titleStr
        }
        if let time = model.addtime {
            self.timeLabel.text = time
        }
        if let state = model.state, let statestr = model.stateStr {
            self.stteLabel.text = statestr
            if state == 0 {
                self.stteLabel.backgroundColor = darkblueColor
            } else if state == 2 {
                self.stteLabel.backgroundColor = UIColor.hc_ColorFromInt(red: 255, green: 105, blue: 0, alpha: 1.0)
            } else {
                self.stteLabel.backgroundColor = UIColor.hc_ColorFromInt(red: 204, green: 204, blue: 204, alpha: 1.0)
            }
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
