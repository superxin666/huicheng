//
//  AddMemoViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/26.
//  Copyright © 2018年 lvxin. All rights reserved.
//  添加备忘录

import UIKit
enum AddMemoViewController_type {
    //   添加      详情         编辑
    case add_type,detail_type,edit_type
}

typealias AddMemoViewControllerBlcok = ()->()

class AddMemoViewController: BaseViewController,MineRequestVCDelegate {
    let backView = AddMemoBackView.loadNib()
    let request : MineRequestVC = MineRequestVC()
    var type : AddMemoViewController_type!
    var alertController : UIAlertController!

    var addSucessBlock  : AddMemoViewControllerBlcok!
    var delSucessBlock  : AddMemoViewControllerBlcok!


    
    /// id
    var momeoID : Int!

    
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
        request.delegate = self
        if let type = self.type {
            if type == .add_type {
                self.addUI()
            } else {
                //获取详情
                self.detailnet()
                self.detailUI()
            }
        } else {
            self.addUI()
        }
        self.view.addSubview(self.backView)
    }
    // MARK: - UI
    func addUI()  {
        self.navigation_title_fontsize(name: "添加备忘录", fontsize: 18)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        self.navigationBar_rightBtn_title(name: "确定",textColour: darkblueColor)
        self.view.isUserInteractionEnabled = true
    }
    
    func detailUI() {
        self.navigation_title_fontsize(name: "查看备忘录", fontsize: 18)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        self.navigationBar_rightBtn_title(name: "操作",textColour: darkblueColor)
        self.view.isUserInteractionEnabled = false
    }
    
    func editUI()  {
        self.navigation_title_fontsize(name: "编辑备忘录", fontsize: 18)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        self.navigationBar_rightBtn_title(name: "保存")
        self.view.isUserInteractionEnabled = true
    }
    
    // MARK: - event response

    override func navigationLeftBtnClick() {
        if self.type == .add_type {
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
        
        } else {
            
            self.navigationController?.popViewController(animated: true)

        }

    }
    
    override func navigationRightBtnClick() {
        if self.type == .add_type {
            //添加
            self.addClick()
        } else if self.type == .detail_type {
            //详情
            self.actionClick()

        } else {
            //编辑
            self.editeNet()
        }
    }
    
    //确认添加
    func addClick() {
        HCLog(message: "确定")
        if backView.textView.isFirstResponder {
            backView.textView.resignFirstResponder()
        }
        self.view.endEditing(true)
        if !(backView.noticeStr.count > 0) {
            SVPMessageShow.showErro(infoStr: "请输入内容")
            return
        }
        if !(backView.timeStr.count > 0) {
            SVPMessageShow.showErro(infoStr: "请输入时间")
            return
        }
        self.addnet()
    }
    
    //操作
    func actionClick() {
        alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let actcion1 = UIAlertAction(title: "编辑", style: .default) { (aciton) in
            self.editUI()
            self.type = .edit_type
        }
        let actcion2 = UIAlertAction(title: "删除", style: .default) { (aciton) in
            self.delnet()
        }
        let actcion3 = UIAlertAction(title: "取消", style: .cancel) { (aciton) in
            self.alertController.dismiss(animated: true, completion: {
                
            })
            
        }
        alertController.addAction(actcion1)
        alertController.addAction(actcion2)
        alertController.addAction(actcion3)
        self.present(alertController, animated: true, completion: nil)
        
    }


    // MARK: - delegate
    func requestSucceed_mine(data: Any,type : MineRequestVC_enum) {
        if type == .memo_save {
            //添加
            let model = data as! CodeData
            if model.code == 1 {
                self.addSucessBlock()
                self.navigationController?.popViewController(animated: true)
            }
        } else if type == .memo_del{
            //删除
            let model = data as! CodeData
            if model.code == 1 {
                self.delSucessBlock()
                self.navigationController?.popViewController(animated: true)
            }

        } else {
            //详情
            let model = data as! memo_getinfoModel
            backView.setData(model: model)
        }
    }
    
    func requestFail_mine() {
        
    }
    
    // MARK: - net
    func addnet() {
        // backView.timeStr,  "2018-12-03 09:00"


        request.memo_saveRequest(n: backView.noticeStr, t:backView.timeStr, i: backView.isNotice, id: 0)

    }
    
    func detailnet() {
        request.memo_getinfoRequest(id: momeoID)
    }
    func delnet()  {

        request.memo_delRequest(id: self.momeoID)

    }
    
    func editeNet() {
        if  self.backView.textView.isFirstResponder{
            self.backView.textView.resignFirstResponder()
        }
         request.memo_saveRequest(n: backView.noticeStr, t: backView.timeStr, i: backView.isNotice, id:momeoID)
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
