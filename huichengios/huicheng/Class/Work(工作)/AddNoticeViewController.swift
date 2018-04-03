//
//  AddNoticeViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/4/1.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
enum AddNoticeViewController_type {
//    添加  详情
    case addNotice,detail
}
typealias AddNoticeViewControllerBlock = ()->()

class AddNoticeViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate,WorkRequestVCDelegate,MessageRequestVCDelegate {
    let mainTabelView : UITableView = UITableView()
    let request : WorkRequestVC = WorkRequestVC()
    let messageRequest : MessageRequestVC = MessageRequestVC()
    
    
    /// 类型
    var type : AddNoticeViewController_type!
    /// 详情id
    var detailId : Int!
    
    /// 详情数据模型
    var detailModel : newsdetialModel!
    
    
    var titleCell : TitleTableViewCell!
    var contentCell : ContentTableViewCell!
    var fileCell : FileTableViewCell!
    var objectCell :SearchStateTableViewCell!
    var messageCell : MessageNeedTableViewCell!
    
    var alertController : UIAlertController!

    
    /// 操作 0撤回 1发布 2修改 3删除
    var actionNum : Int!
    
    var reflishBlock : AddNoticeViewControllerBlock!
    
    
    // MARK: - life
    override func viewWillLayoutSubviews() {
        mainTabelView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(0)
            make.left.right.equalTo(self.view).offset(0)
            make.bottom.equalTo(self.view).offset(0)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = viewBackColor
        request.delegate = self
        messageRequest.delegate = self
        if type == .addNotice{
            self.navigation_title_fontsize(name: "发布公告", fontsize: 18)
            self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
            self.navigationBar_rightBtn_title(name: "确定")
            request.getobjectlistRequest()
            
            
        } else {
            self.navigation_title_fontsize(name: "公告查看", fontsize: 18)
            self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
            self.navigationBar_rightBtn_title(name: "操作")
            messageRequest.newsdetialRequest(id: detailId)
        }
        self.creatUI()
    }
    // MARK: - UI
    func creatUI() {
        mainTabelView.backgroundColor = UIColor.clear
        mainTabelView.delegate = self;
        mainTabelView.dataSource = self;
        mainTabelView.tableFooterView = UIView()
        mainTabelView.separatorStyle = .none
        mainTabelView.showsVerticalScrollIndicator = false
        mainTabelView.showsHorizontalScrollIndicator = false
        mainTabelView.backgroundView?.backgroundColor = .clear
        mainTabelView.register(UINib.init(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: TitleTableViewCellID)
        mainTabelView.register(UINib.init(nibName: "ContentTableViewCell", bundle: nil), forCellReuseIdentifier: ContentTableViewCellID)
        mainTabelView.register(UINib.init(nibName: "FileTableViewCell", bundle: nil), forCellReuseIdentifier: FileTableViewCellID)
        mainTabelView.register(UINib.init(nibName: "SearchStateTableViewCell", bundle: nil), forCellReuseIdentifier: Searchcell_expenseID)
        mainTabelView.register(UINib.init(nibName: "MessageNeedTableViewCell", bundle: nil), forCellReuseIdentifier: MessageNeedTableViewCellID)
        self.view.addSubview(mainTabelView)
    }
    // MARK: - delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            titleCell  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
            titleCell.setData_AddNotice(titleStr: "公告标题")
            return titleCell
        } else if indexPath.row == 1 {
            contentCell = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCellID, for: indexPath) as! ContentTableViewCell
            return contentCell
        } else if indexPath.row == 2{
            fileCell = tableView.dequeueReusableCell(withIdentifier: FileTableViewCellID, for: indexPath) as! FileTableViewCell
            
            return fileCell
        } else if indexPath.row == 3 {
            objectCell  = tableView.dequeueReusableCell(withIdentifier: Searchcell_expenseID, for: indexPath) as! SearchStateTableViewCell
            objectCell.type = .Object
            objectCell.setData_Object(titleStr: "接受对象")
            return objectCell
        } else {
            messageCell  = tableView.dequeueReusableCell(withIdentifier: MessageNeedTableViewCellID, for: indexPath) as! MessageNeedTableViewCell
            
            return messageCell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return TitleTableViewCellH
        } else if indexPath.row == 1 {
            return ContentTableViewCellH
        } else if indexPath.row == 2{
            return FileTableViewCellH
        } else if indexPath.row == 3 {
            return ObjectTableViewCellH
        } else {
            return MessageNeedTableViewCellH
        }
    }
    // MARK: - net

    func requestSucceed_work(data: Any, type: WorkRequestVC_enum) {
        SVPMessageShow.dismissSVP()
        if type == .getobjectlist {
            //获取对象
            let arr : [getobjectlistModel] = data as! [getobjectlistModel]
            self.objectCell.dataArr = arr
      
            HCLog(message: self.objectCell.dataArr.count)
            
            self.objectCell.pickView.reloadAllComponents()
        } else if type == .save || type == .newspublic {
            //添加  发布 撤销
            let model : CodeData = data as! CodeData
            if model.code == 1 {
              self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func requestFail_work() {
        
    }
    
    
    func requestSucceed_message(data: Any) {
    //获取详情
        let model : newsdetialModel = data as! newsdetialModel
        detailModel = model
        titleCell.setData_noticeDetail(titleStr: "", contentStr: model.title)
        contentCell.setData_notice(contentStr: model.content)
        let objectmodel : getobjectlistModel = getobjectlistModel()
        objectmodel.name = model.object
        objectmodel.id = model.objectid
        objectCell.dataArr = [objectmodel]
        objectCell.pickView.reloadAllComponents()
        
        
        if detailModel.state == 1 {
            //已经发布 页面不能编辑
            self.mainTabelView.isUserInteractionEnabled = false
        }
//        messageCell.setData_needState(need: model)
        
    }
    
    func requestFail_message() {
        
    }
    
    
    
    func publishRequest()  {
        request.newspublicRequest(id: self.detailId, s: 1)
        
    }
    
    func recallRequest() {
        request.newspublicRequest(id: self.detailId, s: 2)

    }

    func deleRequest() {
        
        
    }
    
    func editeRequest() {
        
        self.addRequest()
    }
    
    func addRequest()  {
        if titleCell.textField.isFirstResponder{
            titleCell.textField.resignFirstResponder()
        }
        if contentCell.textView.isFirstResponder{
            contentCell.textView.resignFirstResponder()
        }
        
        if !(titleCell.conTent.count > 0 ){
            SVPMessageShow.showErro(infoStr: "请输入标题")
            return
        }
        if !(contentCell.conTent.count > 0 ){
            SVPMessageShow.showErro(infoStr: "请输入内容")
            return
        }
        if !(objectCell.cuurectID.count > 0) {
            SVPMessageShow.showErro(infoStr: "请选择接受对象")
            return
        }
        //o: objectCell.cuurectID
        SVPMessageShow.showLoad(title:"发布中~~")
        if let id = detailId {
            request.saveRequest(id: "\(id)", t: titleCell.conTent, n: contentCell.conTent, o: objectCell.cuurectID, s: 0, d: messageCell.need)
        } else {
            request.saveRequest(id: "", t: titleCell.conTent, n: contentCell.conTent, o: objectCell.cuurectID, s: 0, d: messageCell.need)
        }
    }
    
    
    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    override func navigationRightBtnClick() {
        if type == .addNotice{
 
            self.addRequest()
            
        } else {
            HCLog(message: "操作")
            weak var weakself = self
            if detailModel.state == 1 {
                //已经发布 只有撤回
                alertController = UIAlertController(title: nil, message: "", preferredStyle: .actionSheet)
                let sureAction = UIAlertAction(title: "撤回", style: .default) { (action) in
                    HCLog(message: "撤回")
                    weakself?.actionNum = 0
                    weakself?.showSure()
                    
                }
                let cancleAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
                    self.alertController.dismiss(animated: true, completion: {
                        
                    })
                }
                alertController.addAction(cancleAction)
                alertController.addAction(sureAction)
                self.present((alertController)!, animated: true, completion: nil)

                
            } else {
                //未发布 已经撤回  发布 修改 删除
                alertController = UIAlertController(title: nil, message: "", preferredStyle: .actionSheet)
                
                
                let action1 = UIAlertAction(title: "发布", style: .default) { (action) in
                    HCLog(message: "发布")
                    weakself?.actionNum = 1
                    weakself?.showSure()
                    
                    
                }
                let action2 = UIAlertAction(title: "修改", style: .default) { (action) in
                    HCLog(message: "修改")
                    weakself?.actionNum = 2
                    weakself?.showSure()

                }
                let action3 = UIAlertAction(title: "删除", style: .default) { (action) in
                    HCLog(message: "删除")
                    weakself?.actionNum = 3
                    weakself?.showSure()
                }
                let action4 = UIAlertAction(title: "取消", style: .cancel) { (action) in
                    self.alertController.dismiss(animated: true, completion: {
                        
                    })

                }
                alertController.addAction(action1)
                alertController.addAction(action2)
                alertController.addAction(action3)
                alertController.addAction(action4)
                self.present((alertController)!, animated: true, completion: nil)

            }
            
            
        }
    }
    
    func showSure() {
        alertController =  UIAlertController(title: nil, message: "确定要操作吗", preferredStyle: .alert)
        let sureAction = UIAlertAction(title: "确定", style: .default) { (action) in
            HCLog(message: "确定")
            if self.actionNum == 0 {
                //撤回
                self.recallRequest()
                
            } else if self.actionNum == 1 {
                //发布
                self.publishRequest()
                
            } else if self.actionNum == 2 {
                //编辑
                self.editeRequest()
                
            } else {
                //删除
                self.deleRequest()
                
            }
            
        }
        let cancleAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
            self.alertController.dismiss(animated: true, completion: {
                HCLog(message: "取消")
            })
        }
        alertController.addAction(cancleAction)
        alertController.addAction(sureAction)
        self.present((alertController)!, animated: true, completion: nil)
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
