//
//  IconTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/10/20.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let IconTableViewCellId = "IconTableViewCell_id"
let IconTableViewCellH = CGFloat(80)


class IconTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!


    func setData(nameStr : String,iconStr : String) {
        self.nameLabel.text = nameStr
        self.iconImageView .setImage_kf(imageName: iconStr, placeholderImage: #imageLiteral(resourceName: "log_persion"))
    }
}
