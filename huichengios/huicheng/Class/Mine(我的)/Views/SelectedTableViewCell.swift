//
//  SelectedTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/4/24.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit

let SelectedTableViewCellH = CGFloat(50)
let SelectedTableViewCellID = "SelectedTableViewCell_id"


class SelectedTableViewCell: UITableViewCell {
    @IBOutlet weak var specialBtn: UIButton!

    @IBOutlet weak var normalBtn: UIButton!

    var lastBtn : UIButton!



    @IBAction func btnClick(_ sender: UIButton) {
        if sender.isSelected {
            return
        }
        HCLog(message: sender.tag)
        lastBtn.isSelected = sender.isSelected
        sender.isSelected = !sender.isSelected
        lastBtn = sender

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
