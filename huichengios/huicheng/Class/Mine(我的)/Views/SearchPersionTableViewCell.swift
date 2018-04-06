//
//  SearchPersionTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/3/31.
//  Copyright © 2018年 lvxin. All rights reserved.
//  交款人  合同编号

import UIKit
let SearchPersionTableViewCellID = "SearchPersionTableViewCell_id"

class SearchPersionTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    
    /// 内容
    var contentStr : String = ""
    
    @IBAction func endText(_ sender: UITextField) {
        if let str = sender.text {
            contentStr = str
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
    
    func setData(titleStr : String,fieldTag : Int) {
        self.titleLabel.textAlignment = .left
        self.titleLabel.text = titleStr
    }
    
}
