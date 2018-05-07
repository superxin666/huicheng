//
//  NoticeTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/5/7.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let NoticeTableViewCellID = "NoticeTableViewCell_ID"
let NoticeTableViewCellh = CGFloat(50)



class NoticeTableViewCell: UITableViewCell {
    var isNotice : Bool = false


    @IBOutlet weak var contentLabel: UILabel!

    @IBAction func btnClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        isNotice  = sender.isSelected

    }

    func setData(contentStr : String)  {
        self.contentLabel.textColor = .red
        self.contentLabel.text = contentStr
    }



    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
