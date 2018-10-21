//
//  PersonHeadCollectionViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/10/20.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let PersonHeadCollectionViewCellId = "PersonHeadCollectionViewCell_id"

class PersonHeadCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var lineView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(title : String,selected : String)  {
        self.titleLabel.text = title

        if selected == "1" {
            self.titleLabel.textColor = orangeColor
            self.lineView.backgroundColor = orangeColor
        } else {
            self.titleLabel.textColor = darkblueColor
            self.lineView.backgroundColor = .clear
        }
    }

}
