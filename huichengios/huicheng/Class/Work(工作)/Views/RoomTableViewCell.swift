//
//  RoomTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/4/23.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let RoomTableViewCellID = "UITableViewCell_id"
let RoomTableViewCellH = CGFloat(80)


class RoomTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!

    func setData(model : roomModel)  {
        if let bt = model.bt,let et = model.et,let ut = model.ut {
            let str = String.hc_getDate_string(dateStr: bt) + "~" + String.hc_getDate_string(dateStr: et)+"\(ut)小时"
            self.titleLabel.text = str

        }
        var str = ""

        if let total = model.total {
            str = "\(total)人"
        }
        if let name = model.name {
            str = str + "   " + name
        }
        self.contentLabel.text = str

        if let stateStr = model.stateStr {
            self.stateLabel.text = stateStr
        }
        if let state = model.state {
            self.stateLabel.backgroundColor = darkblueColor
            self.stateLabel.textColor = .white
        }

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
