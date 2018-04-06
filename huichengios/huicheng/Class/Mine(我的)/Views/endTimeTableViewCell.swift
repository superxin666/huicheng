//
//  endTimeTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/4/2.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let endTimeTableViewCellid = "endTimeTableViewCell_id"

class endTimeTableViewCell: UITableViewCell {
    @IBOutlet weak var titleNameLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(titleStr  :String,tag : Int)  {
        self.titleNameLabel.text = titleStr
    }
    func setTime(str : String) {
        self.timeLabel.text = str
    }
}
