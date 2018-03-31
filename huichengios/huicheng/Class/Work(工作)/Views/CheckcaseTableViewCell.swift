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
    
    /// 名字
    var nameStr : String!
    /// 身份证号
    var num :String!
    
    
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBAction func endText(_ sender: UITextField) {
        if sender.tag == 0 {
            //关系人
            if let str = sender.text {
                nameStr = str
            } else {
                nameStr = ""
            }
            
        } else {
            //身份证
            if let str = sender.text {
                num = str
            } else {
                num = ""
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    func setData(titleStr : String, rowTag : Int) {
        self.titleLabel.text = titleStr
        textField.tag = rowTag

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
