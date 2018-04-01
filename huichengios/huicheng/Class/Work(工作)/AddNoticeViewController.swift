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

class AddNoticeViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate {
    let mainTabelView : UITableView = UITableView()
    let request : WorkRequestVC = WorkRequestVC()
    var type : AddNoticeViewController_type!
    
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
        if type == .addNotice{
            self.navigation_title_fontsize(name: "发布公告", fontsize: 18)
            self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
            self.navigationBar_rightBtn_title(name: "确定")
            request.getobjectlistRequest()
            
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
        mainTabelView.register(UINib.init(nibName: "ObjectTableViewCell", bundle: nil), forCellReuseIdentifier: ObjectTableViewCellID)
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
            let cell : TitleTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
            cell.setData_AddNotice(titleStr: "公告标题")
            return cell
        } else if indexPath.row == 1 {
            let cell : ContentTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCellID, for: indexPath) as! ContentTableViewCell
            
            return cell
            
        } else if indexPath.row == 2{
            let cell : FileTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: FileTableViewCellID, for: indexPath) as! FileTableViewCell
            return cell
        } else if indexPath.row == 3 {
            let cell :SearchStateTableViewCell  = tableView.dequeueReusableCell(withIdentifier: Searchcell_expenseID, for: indexPath) as! SearchStateTableViewCell
            cell.setData_Object(titleStr: "接受对象")
            cell.type = .Object
            return cell
        } else {
            let cell : MessageNeedTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: MessageNeedTableViewCellID, for: indexPath) as! MessageNeedTableViewCell
            
            return cell
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
    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    override func navigationRightBtnClick() {
        if type == .addNotice{
            HCLog(message: "确定")
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
