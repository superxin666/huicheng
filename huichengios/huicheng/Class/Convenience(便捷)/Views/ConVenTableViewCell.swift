//
//  ConVenTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/3/24.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit

class ConVenTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var emailLabel: UIButton!
    
    @IBOutlet weak var phoneLabel: UIButton!
    
    @IBOutlet weak var nameLabel: UIButton!
    
    @IBOutlet weak var adrLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(model : quick_getlistModel) {
        if let name = model.name {
            self.titleLabel.text = name
        }
        if let adr  = model.addr {
            self.adrLabel.text = adr
        }
        if let contactuser  = model.contactuser {
            self.nameLabel.setTitle(contactuser, for: .normal)
        }
        if let phone  = model.phone {
            self.phoneLabel.setTitle(phone, for: .normal)
        }
        if let email  = model.email {
            self.emailLabel.setTitle(email, for: .normal)
        }
    }
    
}
