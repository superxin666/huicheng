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
        } else {
            self.titleLabel.text = "13"
        }
//
        if let titleStr = model.titlesStr {
            self.subLabel.text = titleStr
        } else {
            self.subLabel.text = "12344"
        }
        if let time = model.addtime {
            self.timeLabel.text = time
        } else {
            self.timeLabel.text = "asdf"
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
