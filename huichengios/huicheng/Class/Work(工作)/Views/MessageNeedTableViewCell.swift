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
    
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        
        
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
