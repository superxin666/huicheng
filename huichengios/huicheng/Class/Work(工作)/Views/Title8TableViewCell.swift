//
//  Title8TableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/8/27.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let Title8TableViewCellID = "Title8TableViewCell_id"
let Title8TableViewCellH = CGFloat(50)


class Title8TableViewCell: UITableViewCell {
    @IBOutlet weak var titleNameLabel: UILabel!
    
    @IBOutlet weak var fileNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(titleStr : String,contentSTr : String) {
        self.titleNameLabel.text = titleStr
        self.fileNameLabel.text = contentSTr
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
