//
//  Title7TableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/6/6.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let Title7TableViewCellH = CGFloat(80)
let Title7TableViewCellID = "Title7TableViewCell_id"

class Title7TableViewCell: UITableViewCell {
    @IBOutlet weak var timeLabel: UILabel!

    @IBOutlet weak var contentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData_share(model : sharegetreplyModel){
        if let content = model.content {
            let attrStr = try! NSAttributedString(
                data: content.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                options:[NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            self.contentLabel.attributedText =  attrStr
        }

        var str = ""
        if let user = model.user {
            str.append(user)
        }
        if let addtime = model.addtime {
            str.append("  发表于：")
            str.append(addtime)
        }
        self.timeLabel.text = str
    }
    
}
