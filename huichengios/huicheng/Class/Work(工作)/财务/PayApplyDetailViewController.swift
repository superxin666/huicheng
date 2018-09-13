//
//  PayApplyDetailViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/8/26.
//  Copyright © 2018年 lvxin. All rights reserved.
//  线下支付详情

import UIKit
typealias PayApplyDetailViewControllerBlock = ()->()
class PayApplyDetailViewController: BaseViewController,Work2RequestVCDelegate,UITableViewDelegate,UITableViewDataSource {

    var sucessBlock : PayApplyDetailViewControllerBlock!


    let mainTabelView : UITableView = UITableView()
    let request : Work2RequestVC = Work2RequestVC()
    var dataModel : pay_applyinfoModel!
    var id : String!

    var alertController : UIAlertController!

    var titleArr : [String] = []

    let name1 = ["收款律师","金额","支付信息","卡号","分成比列","申请时间","状态"]
    var content1 :[String] = []

    let name2 = ["报销类型","发票金额","附件张数","申请时间","审核人","审核时间"]
    var content2 : [String] = []
    
    let name3 = ["合同编号","案件编号","案件名称","立案时间","立案律师","合同金额","已付金额"]
    var content3 : [String] = []

    var financeId : Int!



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
        self.navigation_title_fontsize(name: "线下支付", fontsize: 18)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        self.navigationBar_rightBtn_title(name: "操作")
        self.creatUI()
        request.delegate = self
        request.financePayapplyinfo(id: id)

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
        self.view.addSubview(mainTabelView)
    }

    // MARK: - delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        if let model = dataModel {
            return titleArr.count
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let model = dataModel {
            if model.data.type == 0 {
                if section == 0 {
                    return name1.count
                } else {
                    return name3.count
                }
            } else {
                if section == 0 {
                    return name1.count
                } else {
                    return name2.count
                }
            }
        } else {
            return 0
        }

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let model = dataModel {
            if indexPath.section == 0 {
                let cell : Title4TableViewCell!  = tableView.dequeueReusableCell(withIdentifier: Title4TableViewCellID, for: indexPath) as! Title4TableViewCell
                cell.setData_PayApplyDetail(titleStr: name1[indexPath.row], contentStr: content1[indexPath.row])
                return cell

            } else  {
                let cell : Title4TableViewCell!  = tableView.dequeueReusableCell(withIdentifier: Title4TableViewCellID, for: indexPath) as! Title4TableViewCell
                var titleStrArr : [String] = []
                var contentStrArr : [String] = []

                if model.data.type == 0 {
                    titleStrArr = name3
                    contentStrArr = content3
                } else {
                    titleStrArr = name2
                    contentStrArr = content2
                }
                cell.setData_PayApplyDetail(titleStr: titleStrArr[indexPath.row], contentStr: contentStrArr[indexPath.row])
                return cell
            }


        } else {
            let cell : UITableViewCell = UITableViewCell()
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FinanceDetialViewControllerCellH
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = FinanceDetialHeadView.loadNib()
        view.setData(name: titleArr[section])
        view.backgroundColor = UIColor.hc_colorFromRGB(rgbValue: 0xcccccc)
        return view
    }

    func requestSucceed_work2(data: Any, type: Work2RequestVC_enum) {
        if type == .pay_applyinfo {
            dataModel = data as! pay_applyinfoModel
            if dataModel.data.type == 0 {
                //分成
                titleArr = ["支付信息","合同信息"]
                content1.append(dataModel.data.user)
                content1.append("\(dataModel.data.money!)元")
                content1.append(dataModel.data.bank)
                content1.append(dataModel.data.cardno)
                content1.append("\(dataModel.data.prpportion!)%")//比例
                content1.append(dataModel.data.addtime)
                content1.append(dataModel.data.stateStr)


                content3.append(dataModel.income.dealnum)
                content3.append(dataModel.data.casenum)//案件编号
                content3.append(dataModel.data.casename) //案件名称
                content3.append(dataModel.income.regtime)
                content3.append(dataModel.income.reguser)
//                content3.append("")//承办律师
                content3.append("\(dataModel.data.dealamount!)元")
                content3.append("\(dataModel.data.paymoney!)元")

            } else {
                //报销
                titleArr = ["支付信息","报销信息",]
                content1.append(dataModel.data.user)
                content1.append("\(dataModel.data.money!)元")
                content1.append(dataModel.data.bank)
                content1.append(dataModel.data.cardno)
                content1.append("\(dataModel.data.prpportion!)")//比例
                content1.append(dataModel.data.addtime)
                content1.append(dataModel.data.stateStr)


                content2.append(dataModel.expense.typeStr)
                content2.append("\(dataModel.expense.money!)元")
                content2.append("\(dataModel.expense.total!)元")
                content2.append(dataModel.expense.addtime)
                content2.append(dataModel.data.applyname)
                content2.append(dataModel.data.applytime)

            }
            self.mainTabelView.reloadData()

        } else if type == .pay_del {
            self.sucessBlock()
            self.navigationLeftBtnClick()

        } else if type == .pay_save {
            self.sucessBlock()
            self.navigationLeftBtnClick()
            
        }

    }


    func requestFail_work2() {

    }
    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }

    override func navigationRightBtnClick() {
        HCLog(message: "操作")
        if dataModel.data.state == 3 {
            //已支付 删除操作
            HCLog(message: "以支付")
            alertController = UIAlertController(title: nil, message: "删除", preferredStyle: .actionSheet)
            let sureAction = UIAlertAction(title: "确定", style: .default) { (action) in
                self.delReuqest()
            }

            let cancleAction = UIAlertAction(title: "取消", style: .cancel) { (action) in

            }
            alertController.addAction(cancleAction)
            alertController.addAction(sureAction)
            self.present((alertController)!, animated: true, completion: nil)


        } else {
            //删除 支付
            HCLog(message: "其他")
            alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

            let sureAction = UIAlertAction(title: "支付", style: .default) { (action) in
                self.payRequest()
            }

            let sureAction2 = UIAlertAction(title: "删除", style: .default) { (action) in
                self.delReuqest()
            }

            let cancleAction = UIAlertAction(title: "取消", style: .cancel) { (action) in

            }
            alertController.addAction(cancleAction)
            alertController.addAction(sureAction)
            alertController.addAction(sureAction2)
            self.present((alertController)!, animated: true, completion: nil)

        }

    }


    func delReuqest() {
        request.pay_delRequest(id: id)
    }

    func payRequest() {
        request.pay_saveRequest(id: id)

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
