//
//  InfoFirstTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/3/18.
//  Copyright © 2018年 lvxin. All rights reserved.
//  信息 头部cell

import UIKit

class InfoFirstTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(imageUrl : String) {
        iconImageView.setImage_kf(imageName: imageUrl, placeholderImage: #imageLiteral(resourceName: "log_persion"))
    }
    
}
