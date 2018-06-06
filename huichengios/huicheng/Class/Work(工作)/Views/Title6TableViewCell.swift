//
//  Title6TableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/6/3.
//  Copyright © 2018年 lvxin. All rights reserved.
//  

import UIKit
let Title6TableViewCellH = CGFloat(80)
let  Title6TableViewCellID = "Title6TableViewCell_ID"

class Title6TableViewCell: UITableViewCell {
    @IBOutlet weak var subLabel: UILabel!
    
    @IBOutlet weak var titleNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData_share(model : sharegetinfoModel) {
        if let title = model.title {
            self.titleNameLabel.text = title
        }
        var str = ""
        if let user = model.user {
            str.append(user)
        }

        if let addtime = model.addtime {
            str.append("  发表于：")
            str.append(addtime)
        }
        if let readcount = model.readcount {
            str.append("  阅读次数：")
            str.append("\(readcount)")
        }
        self.subLabel.text = str

    }
    
}
