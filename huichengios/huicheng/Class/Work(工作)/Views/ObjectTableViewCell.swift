//
//  ObjectTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/3/31.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let ObjectTableViewCellH = CGFloat(50)
let ObjectTableViewCellID = "ObjectTableViewCell_ID"
class ObjectTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var pickView: UIPickerView!
    
    
    /// 对象id
    var objectId : Int!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
