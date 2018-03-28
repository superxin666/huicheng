//
//  ResetKeyViewControllerViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/24.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit

class ResetKeyViewControllerViewController: BaseViewController,MineRequestVCDelegate {
    let backView = ResetKeyView.loadNib()
    let request : MineRequestVC = MineRequestVC()

    override func viewWillLayoutSubviews() {
        backView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(LNAVIGATION_HEIGHT)
            make.left.right.equalTo(self.view).offset(0)
            make.height.equalTo(150)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = viewBackColor
        self.navigation_title_fontsize(name: "修改密码", fontsize: 18)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        self.navigationBar_rightBtn_title(name: "确定")
        self.view.addSubview(backView)
    }
    
    // MARK: - delegate
    func requestSucceed(data: Any,type : MineRequestVC_enum) {
        let model = data as! CodeData
        if model.code == 1 {
            UserInfoLoaclManger.cleanKey()
            let dele :AppDelegate = UIApplication.shared.delegate as! AppDelegate
            dele.showLogin()
        }
        
    }
    
    func requestFail() {
        
    }

    
    // MARK: - Navigation

    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    override func navigationRightBtnClick() {
        if backView.oldTextField.isFirstResponder {
            backView.oldTextField.resignFirstResponder()
        }
        if backView.newTextField.isFirstResponder {
            backView.newTextField.resignFirstResponder()
        }
        if backView.sureTextField.isFirstResponder {
            backView.sureTextField.resignFirstResponder()
        }
        
        HCLog(message: "确定")
        if !(backView.oldkey.count > 0) {
            SVPMessageShow.showErro(infoStr: "请输入旧密码")
            return
        }
        if !(backView.newkey.count > 0) {
            SVPMessageShow.showErro(infoStr: "请输入新密码")
            return
        }
        if !(backView.surekey.count > 0) {
            SVPMessageShow.showErro(infoStr: "请输入确认密码")
            return
        }
        if !(backView.newkey == backView.surekey) {
            SVPMessageShow.showErro(infoStr: "请输入相同的新密码与确认密码")
            return
        }
        request.delegate = self
        request.resetKey(op: backView.oldkey, np: backView.newkey)
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
