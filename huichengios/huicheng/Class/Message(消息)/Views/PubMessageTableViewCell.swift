//
//  PubMessageTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/3/17.
//  Copyright © 2018年 lvxin. All rights reserved.
//  公告cell

import UIKit

class PubMessageTableViewCell: UITableViewCell {
    @IBOutlet weak var timebtn: UIButton!
    
    @IBOutlet weak var titleLabel: UIButton!
    
    @IBOutlet weak var subTitleLabel: UIButton!
    @IBAction func redBtnClick(_ sender: UIButton) {
        HCLog(message: "查看全文")
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
