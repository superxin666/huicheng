//
//  AddExpenseViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/29.
//  Copyright © 2018年 lvxin. All rights reserved.
//  添加报销申请

import UIKit

class AddExpenseViewController: BaseViewController {
    var backView : AddExpenseBackView!
    
    
    override func viewWillLayoutSubviews() {
        backView.snp.makeConstraints { (make) in
            make.top.equalTo(LNAVIGATION_HEIGHT)
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = viewBackColor
        self.navigation_title_fontsize(name: "报销申请", fontsize: 18)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        self.navigationBar_rightBtn_title(name: "确定")
        backView = AddExpenseBackView.loadNib()
        self.view.addSubview(backView)
    }
    
    
    // MARK: - net

    
    
    // MARK: - response
    override func navigationRightBtnClick() {
        HCLog(message: "确定")
    }
    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
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
