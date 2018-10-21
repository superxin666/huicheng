//
//  ImageTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/10/21.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let ImageTableViewCellH = CGFloat(80)
let ImageTableViewCellID = "ImageTableViewCell_id"

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!


    func setData(titleStr : String, imageStr : String) {
        self.nameLabel.text = titleStr
        self.iconImageView .setImage_kf2(imageName: imageStr)
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
