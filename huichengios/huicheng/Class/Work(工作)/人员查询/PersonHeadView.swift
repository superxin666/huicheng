//
//  PersonHeadView.swift
//  huicheng
//
//  Created by lvxin on 2018/10/21.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit

class PersonHeadView: UIView,NibLoadable {

    @IBOutlet weak var namaLabel: UILabel!


    func setData(titleStr : String) {
        self.namaLabel.text = titleStr
    }



    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
