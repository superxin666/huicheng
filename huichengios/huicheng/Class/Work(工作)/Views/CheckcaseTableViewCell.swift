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
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBAction func endText(_ sender: UITextField) {
        
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
