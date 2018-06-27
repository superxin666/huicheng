//
//  BankDetailViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/6/27.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit

class BankDetailViewController: BaseTableViewController,WorkRequestVCDelegate,TitleTableViewCellDelegate {
    let mainTabelView : UITableView = UITableView()
    let requestVC = WorkRequestVC()
    var dataModel : bank_getlistModel!
    var nameArr : [String] = ["账号","姓名","支行","户名","卡号","分所","部门","状态",]
    var contentArr : [String] = []
    var bankId : Int!
    var bank : String = ""
    var name : String = ""
    var card : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = viewBackColor
        self.creatUI()
        requestVC.bank_getinfoRequest(id: bankId)
        requestVC.delegate = self
        self.navigation_title_fontsize(name: "银行信息", fontsize: 18)
        self.navigationBar_rightBtn_title(name: "保存")
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))

    }
    // MARK: - UI
    func creatUI() {
        mainTabelView.backgroundColor = UIColor.white
        mainTabelView.delegate = self;
        mainTabelView.dataSource = self;
        mainTabelView.tableFooterView = UIView()
        mainTabelView.separatorStyle = .none
        mainTabelView.showsVerticalScrollIndicator = false
        mainTabelView.showsHorizontalScrollIndicator = false
        mainTabelView.backgroundView?.backgroundColor = .clear
        mainTabelView.register(UINib.init(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: TitleTableViewCellID)
        self.tableView = mainTabelView
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : TitleTableViewCell  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
        cell.delegate = self
        if contentArr.count > 0 {
            cell.setData_bankInfo(titleStr: nameArr[indexPath.row], contentStr: contentArr[indexPath.row], indexPath: indexPath)
        } else {
            cell.setData_bankInfo(titleStr: nameArr[indexPath.row], contentStr: "", indexPath: indexPath)
        }
        if indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 {
            cell.isUserInteractionEnabled = true
        } else {
            cell.isUserInteractionEnabled = false
        }
        return cell
    }

    func endEdite(inputStr: String, tagNum: Int) {
        if tagNum == 2 {
            bank = inputStr
        } else if tagNum == 3 {
            name = inputStr
        } else {
            card = inputStr
        }
    }

    override func navigationRightBtnClick() {
        self.view.endEditing(true)
        requestVC.bank_saveRequest(id: bankId, bank: bank, name: name, card: card)

    }
    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    func requestSucceed_work(data: Any, type: WorkRequestVC_enum) {
        if type == .bank_getinfo {
            dataModel = data as! bank_getlistModel
            if let str = dataModel.username {
                contentArr.append(str)
            } else {
                contentArr.append("")
            }
            if let str = dataModel.name {

                contentArr.append(str)
            } else {
                contentArr.append("")
            }
            if let str = dataModel.subbranch {
                bank = str
                contentArr.append(str)
            } else {
                contentArr.append("")
            }
            if let str = dataModel.bankname {
                name = str
                contentArr.append(str)
            } else {
                contentArr.append("")
            }
            if let str = dataModel.bankcard {
                card = str
                contentArr.append(str)
            } else {
                contentArr.append("")
            }
            if let str = dataModel.branch {
                contentArr.append(str)
            } else {
                contentArr.append("")
            }
            if let str = dataModel.department {
                contentArr.append(str)
            } else {
                contentArr.append("")
            }
            if let str = dataModel.stateStr {
                contentArr.append(str)
            } else {
                contentArr.append("")
            }

            self.tableView.reloadData()
        } else {
            self.navigationLeftBtnClick()
        }

    }

    func requestFail_work() {

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
