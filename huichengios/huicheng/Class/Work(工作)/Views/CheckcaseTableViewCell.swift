//
//  CheckcaseTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/4/1.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let CheckcaseTableViewCellID = "CheckcaseTableViewCell_id"

class CheckcaseTableViewCell: UITableViewCell {

    /// 身份证号
    var num :String = ""
    /// 类型
    var typeNum : Int!

    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func endText(_ sender: UITextField) {
        HCLog(message: typeNum)
        if typeNum == 0 {
            //身份证
            if let str = sender.text {
                num = str
            }
        }
        HCLog(message: "身份证号"+num)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code234321344567564321

    }

    func setData(titleStr : String, rowTag : Int) {
        self.titleLabel.text = titleStr
        typeNum = rowTag
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
