//
//  CrtGetinfoImageTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/8/23.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let CrtGetinfoImageTableViewCellH = ip6(250)
let CrtGetinfoImageTableViewCellID = "CrtGetinfoImageTableViewCell_id"

class CrtGetinfoImageTableViewCell: UITableViewCell {
    @IBOutlet weak var titleNameLabel: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(titleStr : String,imageStr : String) {
        self.titleNameLabel.text = "文件类型名称：" +  titleStr

        self.iconImageView.setImage_kf(imageName: imageStr, placeholderImage: #imageLiteral(resourceName: "log_bag"))

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
