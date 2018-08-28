
//
//  ExpenseapplyDetialViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/8/28.
//  Copyright © 2018年 lvxin. All rights reserved.
//  报销审核

import UIKit
typealias ExpenseapplyDetialViewControllerBlock = ()->()

class ExpenseapplyDetialViewController: BaseViewController,WorkRequestVCDelegate,UITableViewDelegate,UITableViewDataSource,SelectedTableViewCellDelegate,ContentTableViewCellDelegate,MineRequestVCDelegate {

    var sucessBlock : ExpenseapplyDetialViewControllerBlock!


    let mainTabelView : UITableView = UITableView()
    let request : WorkRequestVC = WorkRequestVC()
    let mineRequestVC : MineRequestVC = MineRequestVC()


    var dataModel : expense_getinfoModel!

    var id : Int!
    var alertController : UIAlertController!



    let name1 = ["分所","部门","报销人","报销类型","报销金额","附件张数","申请时间"]
    var content1 :[String] = []

    let name2 = ["状态","审核人","审核时间"]
    var content2 : [String] = []



    /// 1-审核通过;2-审核驳回
    var stateStr = "1"

    var nStr : String = ""



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
        self.navigation_title_fontsize(name: "报销审核", fontsize: 18)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))


        let iteam1 = self.getUIBarButtonItem_title(title: "删除", action: #selector(deleClick), vc: self)
        let iteam2 = self.getUIBarButtonItem_title(title: "保存", action: #selector(saveClick), vc: self)
        self.navigationItem.rightBarButtonItems = [iteam2,iteam1]
        
        self.creatUI()
        request.delegate = self

        mineRequestVC.delegate = self
        mineRequestVC.expense_getinfoRequest(id: id!)


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
        mainTabelView.register(UINib.init(nibName: "Title4TableViewCell", bundle: nil), forCellReuseIdentifier: Title4TableViewCellID)
        mainTabelView.register(UINib.init(nibName: "SelectedTableViewCell", bundle: nil), forCellReuseIdentifier: SelectedTableViewCellID)
        mainTabelView.register(UINib.init(nibName: "ContentTableViewCell", bundle: nil), forCellReuseIdentifier: ContentTableViewCellID)
        self.view.addSubview(mainTabelView)
    }

    // MARK: - delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if stateStr == "1" {
                return 1
            } else {
                return 2
            }
        } else if section == 1 {
            return name1.count
        } else {
            return name2.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell : SelectedTableViewCell  = tableView.dequeueReusableCell(withIdentifier: SelectedTableViewCellID, for: indexPath) as! SelectedTableViewCell
                cell.delegate = self
                cell.setData_dealcheckdetail(state: stateStr)
                return cell
            } else {

                let cell : ContentTableViewCell  = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCellID, for: indexPath) as! ContentTableViewCell
                cell.delegate = self
                cell.setData_casecheckDetail(title: "驳回原因", contentCase: nStr, tag: 10)
                return cell
            }
        } else if indexPath.section == 1 {
            let cell : Title4TableViewCell!  = tableView.dequeueReusableCell(withIdentifier: Title4TableViewCellID, for: indexPath) as! Title4TableViewCell

            var str = ""
            if content1.count > 0 {
                str = content1[indexPath.row]
            }
            cell.setData_PayApplyDetail(titleStr: name1[indexPath.row], contentStr: str)
            return cell

        } else  {
            let cell : Title4TableViewCell!  = tableView.dequeueReusableCell(withIdentifier: Title4TableViewCellID, for: indexPath) as! Title4TableViewCell
            var str = ""
            if content2.count > 0 {
                str = content2[indexPath.row]
            }
            cell.setData_PayApplyDetail(titleStr: name2[indexPath.row], contentStr: str)
            return cell
        }
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return FinanceDetialViewControllerCellH
            } else if indexPath.row == 1 {
                return ContentTableViewCellH
            } else {
                return FinanceDetialViewControllerCellH
            }
        } else {
            return FinanceDetialViewControllerCellH
        }
    }


    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 40
        } else if section == 2 {
            return 20
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let view = FinanceDetialHeadView.loadNib()
            view.setData(name: "报销信息")
            view.backgroundColor = UIColor.hc_colorFromRGB(rgbValue: 0xcccccc)
            return view

        } else if section == 2 {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 20))
            view.backgroundColor = UIColor.hc_colorFromRGB(rgbValue: 0xcccccc)
            return view
        } else {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            return view
        }
    }

    func selectedClickDelegate_type(tag: Int, type: String) {
        if type == "0" {
            stateStr = "1"
        } else {
            stateStr = "2"
        }
        self.mainTabelView.reloadSections([0], with: .automatic)

    }

    func endText_content(content: String, tagNum: Int) {
        nStr = content
    }

    func requestSucceed_mine(data: Any, type: MineRequestVC_enum) {
        dataModel = data as! expense_getinfoModel
        content1.append("")
        content1.append("")
        content1.append("")
        content1.append(dataModel.data.typeStr)
        content1.append("\(dataModel.data.money!)")
        content1.append("\(dataModel.data.total!)张")
        content1.append(dataModel.data.addtime)


        content2.append(dataModel.data.stateStr)
        content2.append("")
        content2.append("")

        self.mainTabelView.reloadData()

    }

    func requestFail_mine() {

    }


    func requestSucceed_work(data: Any, type: WorkRequestVC_enum) {
        if type == .expense_applysave {
            self.sucessBlock()
            self.navigationLeftBtnClick()
        } else if type == .expense_del {
            self.sucessBlock()
            self.navigationLeftBtnClick()
        }
    }

    func requestFail_work() {

    }

    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func saveClick()  {

        self.view.endEditing(true)
        if stateStr == "2" {
            if !(nStr.count > 0) {
                SVPMessageShow.showErro(infoStr: "请输入驳回原因")
                return
            }
        }
        request.expense_applysave(id: id!, s: stateStr, n: nStr)

    }

    @objc func deleClick() {
        request.expense_de(id: id!)
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
