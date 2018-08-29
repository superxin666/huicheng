//
//  AddIconComeStep1ViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/7/17.
//  Copyright © 2018年 lvxin. All rights reserved.
//  新增收款

import UIKit

class AddIconComeStep1ViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate,TitleTableViewCellDelegate,Work2RequestVCDelegate {

    let mainTabelView : UITableView = UITableView()
    let nameArr = ["合同编号","委托人","关键字"]
    let request : Work2RequestVC = Work2RequestVC()
    var dataModelArr : [Income_getlistModel] = []


    /// 立案律师/委托人
    var uStr = ""
    /// 合同编号
    var nStr = ""
    /// 关键字
    var kwStr = ""

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
        self.navigation_title_fontsize(name: "新增收款", fontsize: 18)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        self.navigationBar_rightBtn_title(name: "确定")
        request.delegate = self
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
        self.view.addSubview(mainTabelView)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : TitleTableViewCell  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
        cell.setData_ovewdeal(titleStr: nameArr[indexPath.row], indexPath: indexPath)
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TitleTableViewCellH
    }


    func endEdite(inputStr: String, tagNum: Int) {
        if  tagNum == 0 {
            nStr = inputStr
        } else if tagNum == 1 {
            uStr = inputStr
        } else {
            kwStr = inputStr
        }
    }

    func requestSucceed_work2(data: Any, type: Work2RequestVC_enum) {
        SVPMessageShow.dismissSVP()
        dataModelArr = data as! [Income_getlistModel]
        if dataModelArr.count > 0 {
            let vc = AddIncomeStep2ViewController()
            vc.hidesBottomBarWhenPushed = true
            vc.dataModelArr = dataModelArr
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            SVPMessageShow.showErro(infoStr: "未查到相关信息")

        }

    }

    func requestFail_work2() {

    }

    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }

    override func navigationRightBtnClick() {
        HCLog(message: "确定")
        SVPMessageShow.showLoad()
        self.view.endEditing(true)
        if !(uStr.count > 0) && !(nStr.count > 0) && !(kwStr.count > 0) {
            SVPMessageShow.showErro(infoStr: "请至少输入一项")
            return
        }
        request.delegate = self
        request.income_getdealsRequest(u: uStr, n: nStr, kw: kwStr)



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
