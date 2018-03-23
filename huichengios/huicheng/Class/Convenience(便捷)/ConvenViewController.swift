//
//  ConvenViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/5.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit

class ConvenViewController: BaseViewController,ConbenTopViewDelegate {
    var topView : ConbenTopView!
    
    // MARK: - life circle
    override func viewWillLayoutSubviews() {
        topView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(LNAVIGATION_HEIGHT+0.5)
            make.left.right.equalTo(self.view).offset(0)
            make.height.equalTo(40)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = viewBackColor
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "mes_logo"))
        self.navigationBar_rightBtn_image(image:#imageLiteral(resourceName: "mine_search"))
        self.navigation_title_fontsize(name: "便捷", fontsize: 18)
        topView = ConbenTopView.loadNib()
        topView.delegate  = self
        self.view.addSubview(topView)
    }
    // MARK: - delegate
    func btnClick(tag: Int) {
        switch tag {
        case 0:
            HCLog(message: "法院")
        case 1:
            HCLog(message: "检察院")
        case 2:
            HCLog(message: "公安机关")
        case 3:
            HCLog(message: "仲裁委")
        case 4:
            HCLog(message: "看守所")
        default:
            HCLog(message: "没有")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
