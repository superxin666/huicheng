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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(title : String)  {
        self.titleLabel.text = title
    }

}
