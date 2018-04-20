//
//  OverCaseViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/4/20.
//  Copyright © 2018年 lvxin. All rights reserved.
// 申请结案

import UIKit

class OverCaseViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = viewBackColor

        self.navigation_title_fontsize(name: "申请结案", fontsize: 18)
        self.navigationBar_rightBtn_title(name: "确定")
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))

    }

    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    override func navigationRightBtnClick() {
        HCLog(message: "确定")
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
