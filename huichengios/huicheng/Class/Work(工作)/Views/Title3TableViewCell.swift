//
//  Title3TableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/4/20.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let Title3TableViewCellID = "Title3TableViewCell_ID"
let Title3TableViewCellH = CGFloat(50)


class Title3TableViewCell: UITableViewCell {
    @IBOutlet weak var titleNameLabel: UILabel!
    
    @IBOutlet weak var subLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData_deal(titleStr : String, contentStr : String) {
        self.titleNameLabel.text = titleStr
        self.subLabel.text = contentStr
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
