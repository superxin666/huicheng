//
//  AddMemoViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/26.
//  Copyright © 2018年 lvxin. All rights reserved.
//  添加备忘录

import UIKit

class AddMemoViewController: BaseViewController,MineRequestVCDelegate {
    let backView = AddMemoBackView.loadNib()
    let request : MineRequestVC = MineRequestVC()

    
    // MARK: - life
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
        self.navigation_title_fontsize(name: "添加备忘录", fontsize: 18)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        self.navigationBar_rightBtn_title(name: "确定")
        self.view.addSubview(self.backView)

    }
    
    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func navigationRightBtnClick() {
        HCLog(message: "确定")
        if backView.textView.isFirstResponder {
            backView.textView.resignFirstResponder()
        }
        if !(backView.noticeStr.count > 0) {
            SVPMessageShow.showErro(infoStr: "请输入内容")
        }
        request.delegate = self
//        backView.timeStr
        request.memo_saveRequest(n: backView.noticeStr, t: "2018-03-28", i: backView.isNotice, id: 0)
        
        
    }
    func requestSucceed(data: Any) {
        let model = data as! CodeData
        if model.code == 1 {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func requestFail() {
        
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
