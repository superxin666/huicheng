//
//  MessageNeedTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/3/31.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let MessageNeedTableViewCellH = CGFloat(50)
let MessageNeedTableViewCellID = "MessageNeedTableViewCell_ID"
class MessageNeedTableViewCell: UITableViewCell {
    @IBOutlet weak var `switch`: UISwitch!
    @IBOutlet weak var titleLabel: UILabel!
    
    /// 0-不发;1-发短信 默认不发
    var need : Int = 0
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        HCLog(message: sender.isOn)
        if sender.isOn {
            need = 1
        } else {
            need = 0
        }

        
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
