//
//  Title2TableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/4/13.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let Title2TableViewCellID = "Title2TableViewCell_id"
let Title2TableViewCellH = CGFloat(50)

class Title2TableViewCell: UITableViewCell {
    @IBOutlet weak var titleNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(titleStr : String) {
        self.titleNameLabel.textColor = darkblueColor
        self.titleNameLabel.text = titleStr
    }

    
}
