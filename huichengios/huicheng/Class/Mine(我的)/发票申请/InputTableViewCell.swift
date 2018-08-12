//
//  InputTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/8/12.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let InputTableViewCellID = "InputTableViewCell_ID"
let InputTableViewCellH = ip6(50)
protocol InputTableViewCellDelegate {
    func endEdite_input(inputStr : String, tagNum : Int)
}


class InputTableViewCell: UITableViewCell {
    @IBOutlet weak var textFiled: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subNameLabel: UILabel!
    
    var delegate  : InputTableViewCellDelegate!


    
    @IBAction func endInput(_ sender: UITextField) {
        if let str = sender.text {
            HCLog(message: sender.text)
            if let delgate = self.delegate {
                delgate.endEdite_input(inputStr: str, tagNum: self.textFiled.tag)
            }
        }
    }

    func setUpData(name : String,tagNum : Int) {

        textFiled.tag = tagNum
        self.nameLabel.text = name
        HCLog(message: tagNum)

        if tagNum == 3 {
            self.subNameLabel.text = "元"
        } else {
            self.subNameLabel.text = "张"
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
