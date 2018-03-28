//
//  AddMemoViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/26.
//  Copyright © 2018年 lvxin. All rights reserved.
//  添加备忘录

import UIKit
enum AddMemoViewController_type {
    case add_type,detail_type
}
class AddMemoViewController: BaseViewController,MineRequestVCDelegate {
    let backView = AddMemoBackView.loadNib()
    let request : MineRequestVC = MineRequestVC()
    var type : AddMemoViewController_type!
    var alertController : UIAlertController!
    
    
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
    
    
    
    // MARK: - event response

    override func navigationLeftBtnClick() {
        
        alertController = UIAlertController(title: nil, message: "是否放弃本次记录", preferredStyle: .alert)
        let sureAction = UIAlertAction(title: "确定", style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        let cancleAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
            self.alertController.dismiss(animated: true, completion: {
                
            })
        }
        alertController.addAction(cancleAction)
        alertController.addAction(sureAction)
        self.present((alertController)!, animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func navigationRightBtnClick() {
        HCLog(message: "确定")
        if backView.textView.isFirstResponder {
            backView.textView.resignFirstResponder()
        }
        if !(backView.noticeStr.count > 0) {
            SVPMessageShow.showErro(infoStr: "请输入内容")
            return
        }
        if !(backView.timeStr.count > 0) {
            SVPMessageShow.showErro(infoStr: "请输入时间")
            return
        }
        request.delegate = self
        request.memo_saveRequest(n: backView.noticeStr, t: backView.timeStr, i: backView.isNotice, id: 0)
        
        
    }
    // MARK: - delegate
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
