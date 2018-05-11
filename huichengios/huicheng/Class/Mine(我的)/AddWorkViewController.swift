//
//  AddWorkViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/31.
//  Copyright © 2018年 lvxin. All rights reserved.
//  添加工作日志

import UIKit
enum AddWorkViewControllerType {
    case add,detail
}
typealias AddWorkViewControllerBlocl = ()->()
class AddWorkViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate,MineRequestVCDelegate,TitleTableViewCellDelegate,ContentTableViewCellDelegate {
    var sucessBlock : AddWorkViewControllerBlocl!

    let requestVC = MineRequestVC()

    var type : AddWorkViewControllerType!

    let mainTabelView : UITableView = UITableView()

    var workID : Int!

    var workDetailModel : work_getinfoModel!

    var tStr = ""

    var nStr = ""
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
        self.navigation_title_fontsize(name: "工作日志", fontsize: 18)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        requestVC.delegate = self
        if type == .add {
            self.navigationBar_rightBtn_title(name: "确定")
        } else {
            requestVC.work_getinfoRequest(id: self.workID!)
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
        self.view.addSubview(mainTabelView)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell : TitleTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
            cell.delegate = self
            cell.setData_work(titleStr: "标题", congtentStr: tStr)
            if type == .add{
                cell.isUserInteractionEnabled = true
            } else {
                cell.isUserInteractionEnabled = false
            }
            return cell
        } else if indexPath.row == 1 {
            let cell : ContentTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCellID, for: indexPath) as! ContentTableViewCell
            cell.delegate = self
            cell.setData_work(title: "内容", contentCase: nStr)
            if type == .add{
                cell.isUserInteractionEnabled = true
            } else {
                cell.isUserInteractionEnabled = false
            }
            return cell
        } else {
            let cell : FileTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: FileTableViewCellID, for: indexPath) as! FileTableViewCell
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            let vc = FileViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return TitleTableViewCellH
        } else if indexPath.row == 1 {
            return ContentTableViewCellH
        } else {
            return FileTableViewCellH
        }
    }

    func requestSucceed_mine(data: Any, type: MineRequestVC_enum) {
        if type == .work_getinfo {
            //获取详情
            workDetailModel = data as! work_getinfoModel
            tStr = workDetailModel.title
            nStr = workDetailModel.content
            self.mainTabelView.reloadData()
        } else if type == .work_save{
            //保存
            self.sucessBlock()
            self.navigationController?.popViewController(animated: true)
        }
    }

    func requestFail_mine() {

    }
    func endEdite(inputStr: String, tagNum: Int) {
        self.tStr = inputStr
    }
    func endText_content(content: String, tagNum: Int) {
        self.nStr = content
    }
    
    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    override func navigationRightBtnClick() {
        if self.type == .add {
            HCLog(message: "确定")
            self.view.endEditing(true)
            if !(tStr.count > 0){
                SVPMessageShow.showErro(infoStr: "请输入标题")
                return
            }
            if !(nStr.count > 0){
                SVPMessageShow.showErro(infoStr: "请输入内容名")
                return
            }
            requestVC.work_save_apiRequest(t: tStr, n: nStr, a: "")
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
