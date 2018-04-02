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

class AddNoticeViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate,WorkRequestVCDelegate {
    let mainTabelView : UITableView = UITableView()
    let request : WorkRequestVC = WorkRequestVC()
    
    /// 类型
    var type : AddNoticeViewController_type!
    /// 详情数据模型
    var detailModel : newslist1Model!
    
    var titleCell : TitleTableViewCell!
    var contentCell : ContentTableViewCell!
    var fileCell : FileTableViewCell!
    var objectCell :SearchStateTableViewCell!
    var messageCell : MessageNeedTableViewCell!
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
        if type == .addNotice{
            self.navigation_title_fontsize(name: "发布公告", fontsize: 18)
            self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
            self.navigationBar_rightBtn_title(name: "确定")
//            request.getobjectlistRequest()
            
            
        } else {
            self.navigation_title_fontsize(name: "公告查看", fontsize: 18)
            self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
            self.navigationBar_rightBtn_title(name: "操作")
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
    
    func requestSucceed(data: Any, type: WorkRequestVC_enum) {
        SVPMessageShow.dismissSVP()
        if type == .getobjectlist {
            //获取对象
            let arr : [getobjectlistModel] = data as! [getobjectlistModel]
            self.objectCell.dataArr = arr
            self.objectCell.reloadInputViews()
        } else if type == .save {
            //发布
            let model : CodeData = data as! CodeData
            if model.code == 1 {
              self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func requestFail() {
        
    }
    
    // MARK: - net
    
    
    
    
    
    
    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    override func navigationRightBtnClick() {
        if type == .addNotice{
            HCLog(message: "确定")
            if type == .addNotice{
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
//                if !(objectCell.cuurectID.count > 0) {
//                    SVPMessageShow.showErro(infoStr: "请选择接受对象")
//                    return
//                }
                //o: objectCell.cuurectID
                SVPMessageShow.showLoad(title:"发布中")
                request.saveRequest(id: "", t: titleCell.conTent, n: contentCell.conTent, o: "1", s: 0, d: messageCell.need)
            }
            
            
        } else {
            HCLog(message: "操作")
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
