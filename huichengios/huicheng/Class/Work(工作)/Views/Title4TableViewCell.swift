//
//  Title4TableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/4/20.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let Title4TableViewCellID = "Title4TableViewCell_id"
let Title4TableViewCellH = CGFloat(50)


class Title4TableViewCell: UITableViewCell {
    @IBOutlet weak var titleNameLabel: UILabel!
    
    @IBOutlet weak var subLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    /// 结案申请
    ///
    /// - Parameters:
    ///   - titleStr: <#titleStr description#>
    ///   - contentStr: <#contentStr description#>
    func setData_overCase(titleStr : String,contentStr : String) {
        self.titleNameLabel.text = titleStr
        self.subLabel.text = contentStr
    }
    
}
