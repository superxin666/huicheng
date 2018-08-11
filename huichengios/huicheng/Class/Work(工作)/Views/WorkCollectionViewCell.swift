//
//  WorkCollectionViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/8/11.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit

class WorkCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(name : String) {
        HCLog(message: name)
        self.nameLabel.text = name
        self.iconImageView.image = UIImage(named: name)
    }
}
