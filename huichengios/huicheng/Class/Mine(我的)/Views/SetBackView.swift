//
//  SetBackView.swift
//  huicheng
//
//  Created by lvxin on 2018/3/28.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
protocol SetBackViewDelegate {
    func logoutDelegate()
    func resetKeyDelegate()
    
}
class SetBackView: UIView,NibLoadable {
    var delegate : SetBackViewDelegate!
    
    @IBOutlet weak var logoutBackView: UIView!
    
    @IBOutlet weak var keyBackView: UIView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(resetKeyTap))
        self.keyBackView.addGestureRecognizer(tap1)
        
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(outTap))
        self.logoutBackView.addGestureRecognizer(tap2)
        
    }
    
    @objc func resetKeyTap()  {
        if let delegate = self.delegate {
            delegate.resetKeyDelegate()
        }
//         self.delegate.resetKeyDelegate()
    }
    @objc func outTap(){
        if let delegate = self.delegate {
            delegate.logoutDelegate()
        }

    }

}
