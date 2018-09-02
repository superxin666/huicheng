

//
//  IncomeDetailViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/7/21.
//  Copyright © 2018年 lvxin. All rights reserved.
//  详情

import UIKit
enum IncomeDetailViewControllerType {
    case detial;
}
typealias IncomeDetailViewControllerBlock = ()->()

class IncomeDetailViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate,Work2RequestVCDelegate {

    var sucessBlock : IncomeDetailViewControllerBlock!


    var type : IncomeDetailViewControllerType!
    let requestVC = Work2RequestVC()

    let mainTabelView : UITableView = UITableView()
    var dataModelArr : [Income_getlistModel] = []
    let nameArr = ["合同编号","立案时间","立案律师","委托人","案件组别","合同金额","已付金额","收款金额"]
    var contentArr : [String] = []

    let nameArr1 = ["共收金额","实收金额","收款日期","交款人","发票","发票号","审核情况"]
    var contentArr1: [String] = []

    var dataModel : income_getinfoModel!


    /// 时间
    var timeView : DatePickView = DatePickView.loadNib()

    /// 选项
    let optionView : OptionView = OptionView.loadNib()

     var alertController : UIAlertController!

    var endTimeCell : endTimeTableViewCell!

    var endTimeStr : String = ""

    /// 收款信息 ID，INT 型。新增时可不传，修改时必传
    var id = ""
    /// 合同 ID，INT 型。新增时必传，修改时可不传
    var dealid = ""



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
        self.navigation_title_fontsize(name: "收款详情 ", fontsize: 18)
        self.navigationBar_rightBtn_title(name: "操作")
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        self.creatUI()
        requestVC.delegate = self
        self.detailRequest()



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
        mainTabelView.register(UINib.init(nibName: "Title2TableViewCell", bundle: nil), forCellReuseIdentifier: Title2TableViewCellID)
        self.view.addSubview(mainTabelView)
    }

    func editeClick() {
        let vc : AddIncomeStep3ViewController = AddIncomeStep3ViewController()
        vc.type = .edite
        vc.data2Model = dataModel
        vc.IDstr = self.id
        self.navigationController?.pushViewController(vc, animated: true)
    }

    /// 详情请求
    func detailRequest() {
        requestVC.income_getinfoRequest(id: "\(id)")
    }


    /// 提交审核
    func applyCheck() {
        requestVC.income_save(id: "\(id)", issubmit: "1")
    }

    /// 删除
    func delRequest() {
        requestVC.income_del(id: "\(id)")

    }

    /// 撤回
    func backRequest() {
   
        requestVC.income_cancel(id:"\(id)")
    }



    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
             return nameArr.count
        } else {
            return nameArr1.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 7 {
                let cell : Title2TableViewCell  = tableView.dequeueReusableCell(withIdentifier: Title2TableViewCellID, for: indexPath) as! Title2TableViewCell
                cell.setData(titleStr: "收款记录")
                return cell

            } else {
                let cell : Title4TableViewCell  = tableView.dequeueReusableCell(withIdentifier: Title4TableViewCellID, for: indexPath) as! Title4TableViewCell
                if contentArr.count > 0 {
                    cell.setData_overCase(titleStr: nameArr[indexPath.row], contentStr: contentArr[indexPath.row])
                }
                return cell
            }

        } else {
            if indexPath.row == 6 {
                let cell : Title2TableViewCell  = tableView.dequeueReusableCell(withIdentifier: Title2TableViewCellID, for: indexPath) as! Title2TableViewCell
                cell.setData(titleStr: "审核情况")
                return cell
            } else {
                let cell : Title4TableViewCell  = tableView.dequeueReusableCell(withIdentifier: Title4TableViewCellID, for: indexPath) as! Title4TableViewCell
                if contentArr1.count > 0 {
                    cell.setData_overCase(titleStr: nameArr1[indexPath.row], contentStr: contentArr1[indexPath.row])
                }
                return cell
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Title2TableViewCellH
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        }  else {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 40))
            view.backgroundColor = UIColor.hc_colorFromRGB(rgbValue: 0xcccccc)

            let label = UILabel(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 40))
            label.text = "收款信息"
            label.font = hc_fontThin(15)
            label.textColor = .black

            view.addSubview(label)
            return view
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 40
        }
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)

        if indexPath.section == 0 {
            if indexPath.row == 7 {
                if dataModel.items.count > 0 {
                    let vc = IncomeRecord_ViewController()
                    vc.dataModelArr = dataModel.items
                    vc.hidesBottomBarWhenPushed  = true
                    vc.type = .list_history
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        } else {
            if indexPath.row == 6 {
                let vc = CheckInfoViewController()
                vc.type = .four
                vc.hidesBottomBarWhenPushed = true
                var arr : [String] = []
                arr.append(dataModel.data.stateStr)
                arr.append(dataModel.data.admin)
                arr.append(dataModel.data.applytime)
                arr.append(dataModel.data.note)

                vc.dataArr = arr
                self.navigationController?.pushViewController(vc, animated: true)

            }
        }
    }


    func requestSucceed_work2(data: Any, type: Work2RequestVC_enum) {

        if type == .income_getinfo {
            dataModel = data as! income_getinfoModel
            contentArr.append(dataModel.data.dealnum)
            contentArr.append(dataModel.data.regtime)
            contentArr.append(dataModel.data.reguser)
            contentArr.append(dataModel.data.principal)
            contentArr.append("后台缺失")
            if let str = dataModel.data.dealamount {
                contentArr.append("\(str)元")
            } else {
                contentArr.append("")
            }

            if let str = dataModel.data.dealmoney {
                contentArr.append("\(str)元")
            } else {
                contentArr.append("")
            }



            if let str = dataModel.data.amount {
                contentArr1.append("\(str)元")
            } else {
                contentArr1.append("")
            }

            if let str = dataModel.data.money {
                contentArr1.append("\(str)元")
            } else {
                contentArr1.append("")
            }
            contentArr1.append(dataModel.data.addtime)
            contentArr1.append(dataModel.data.payuser)
            contentArr1.append(dataModel.data.ispaperStr)
            contentArr1.append(dataModel.data.papernum)
            self.mainTabelView.reloadData()

        } else if type == .financeincome_save || type == .income_cancel{
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
        //
        HCLog(message: "操作")

        if dataModel.data.state == -1 {
            //未提交
            alertController = UIAlertController(title: nil, message: "", preferredStyle: .actionSheet)
            let sureAction = UIAlertAction(title: "提交审核", style: .default) { (action) in
                 HCLog(message: "提交审核")
                 self.applyCheck()
            }
            let sureAction2 = UIAlertAction(title: "修改", style: .default) { (action) in
                 HCLog(message: "修改")
                self.editeClick()

            }
            let sureAction3 = UIAlertAction(title: "删除", style: .default) { (action) in
                 HCLog(message: "删除")
                self.delRequest()

            }

            let cancleAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
                self.alertController.dismiss(animated: true, completion: {

                })
            }
            alertController.addAction(cancleAction)
            alertController.addAction(sureAction)
            alertController.addAction(sureAction2)
            alertController.addAction(sureAction3)
            self.present((alertController)!, animated: true, completion: nil)

        } else if dataModel.data.state == 0 {
            //未审核
            alertController = UIAlertController(title: nil, message: "", preferredStyle: .actionSheet)
            let sureAction = UIAlertAction(title: "撤回", style: .default) { (action) in
                HCLog(message: "撤回")
                self.backRequest()

            }
            let cancleAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
                self.alertController.dismiss(animated: true, completion: {

                })
            }
            alertController.addAction(cancleAction)
            alertController.addAction(sureAction)
            self.present((alertController)!, animated: true, completion: nil)

        } else if dataModel.data.state == 1 {
            //已审核
            alertController = UIAlertController(title: nil, message: "", preferredStyle: .actionSheet)
            let sureAction = UIAlertAction(title: "补开发票", style: .default) { (action) in
                HCLog(message: "补开发票")
                

            }
            let cancleAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
                self.alertController.dismiss(animated: true, completion: {

                })
            }
            alertController.addAction(cancleAction)
            alertController.addAction(sureAction)
            self.present((alertController)!, animated: true, completion: nil)




        } else if dataModel.data.state == 2 {
            //已驳回
            alertController = UIAlertController(title: nil, message: "", preferredStyle: .actionSheet)
            let sureAction = UIAlertAction(title: "修改", style: .default) { (action) in
                HCLog(message: "修改")
                self.editeClick()

            }
            let sureAction3 = UIAlertAction(title: "删除", style: .default) { (action) in
                HCLog(message: "删除")
                self.delRequest()
            }

            let cancleAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
                self.alertController.dismiss(animated: true, completion: {

                })
            }
            alertController.addAction(cancleAction)
            alertController.addAction(sureAction)
            alertController.addAction(sureAction3)

            self.present((alertController)!, animated: true, completion: nil)


        } else if dataModel.data.state == 3 {
            // 已支付

        }
    }





}
