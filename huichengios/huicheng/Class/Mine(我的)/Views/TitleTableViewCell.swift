//
//  TitleTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/3/31.
//  Copyright © 2018年 lvxin. All rights reserved.
//  标题

import UIKit
let TitleTableViewCellH = CGFloat(50)
let TitleTableViewCellID = "TitleTableViewCell_ID"
class TitleTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    var conTent :String = ""
    
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var titleNameLabel: UILabel!
    
    
    @IBAction func endText(_ sender: UITextField) {
        if let str = sender.text {
            conTent = str
        }
    }
    
    
    func setData_checkCaseView(titleStr : String) {
        self.titleNameLabel.textColor = darkblueColor
        self.titleNameLabel.text = titleStr
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
