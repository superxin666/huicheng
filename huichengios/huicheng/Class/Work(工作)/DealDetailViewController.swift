
//
//  DealDetailViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/4/20.
//  Copyright © 2018年 lvxin. All rights reserved.
//  合同详情

import UIKit
typealias DealDetailViewControllerBlcok = ()->()

class DealDetailViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,WorkRequestVCDelegate {
    var sucessBlock : DealDetailViewControllerBlcok!

    let mainTabelView : UITableView = UITableView()
    let requestVC = WorkRequestVC()
    var sectionNameArr = ["合同编号","案件类型","案件名称","合同有效期","合同总款","合同扫描件"]
    var sectionContent:[String] = []

    var section2NameArr = ["发票信息","基本情况","委托人情况","对方当事人情况","函件列表","收款记录","审核状态"]
    var dealID : Int!
    var alertController : UIAlertController!

    /// 数据模型
    var dealModel : getinfoDealModel!


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

        self.navigation_title_fontsize(name: "合同详情", fontsize: 18)
        self.navigationBar_rightBtn_title(name: "操作")
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        self.creatUI()
        requestVC.delegate = self
        requestVC.dealgetinfo(id: dealID)
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
        mainTabelView.register(UINib.init(nibName: "Title2TableViewCell", bundle: nil), forCellReuseIdentifier: Title2TableViewCellID)
        mainTabelView.register(UINib.init(nibName: "Title3TableViewCell", bundle: nil), forCellReuseIdentifier: Title3TableViewCellID)

        self.view.addSubview(mainTabelView)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 6
        } else {
            return 7
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 5 {
                let cell : Title2TableViewCell  = tableView.dequeueReusableCell(withIdentifier: Title2TableViewCellID, for: indexPath) as! Title2TableViewCell
                cell.setData(titleStr: sectionNameArr[indexPath.row])
                return cell
            } else {
                let cell : Title3TableViewCell  = tableView.dequeueReusableCell(withIdentifier: Title3TableViewCellID, for: indexPath) as! Title3TableViewCell
                var str = ""
                if indexPath.row < sectionContent.count {
                    str = sectionContent[indexPath.row]
                }
                cell.setData_deal(titleStr: sectionNameArr[indexPath.row], contentStr: str)
                return cell
            }
        } else {
            let cell : Title2TableViewCell  = tableView.dequeueReusableCell(withIdentifier: Title2TableViewCellID, for: indexPath) as! Title2TableViewCell
            cell.setData(titleStr: section2NameArr[indexPath.row])
            return cell

        }

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                HCLog(message: "发票信息")
            } else if indexPath.row == 1 {
                HCLog(message: "基本情况")
                var arr : [String] = []
                var arr2 : [String] = []
                let vc = BaseInfoViewController()
                arr.append(dealModel.rStr)
                arr.append(dealModel.rt)
                arr.append(dealModel.w1Str)
                arr.append(dealModel.w2Str)
                arr2.append(dealModel.ct)
                arr2.append(dealModel.sj)
                vc.dataArr = arr
                vc.dataArr2 = arr2
                self.navigationController?.pushViewController(vc, animated: true)

            }else if indexPath.row == 2 {
                HCLog(message: "委托人情况")
                var arr : [String] = []
                //委托人情况
                let vc = CasePersionViewController()
                vc.type =  .principal_detail
                arr.append(dealModel.pn)
                arr.append(dealModel.pc)
                arr.append(dealModel.pp)
                arr.append(dealModel.pz)
                arr.append(dealModel.pj)
                arr.append(dealModel.pd)
                arr.append(dealModel.pa)
                vc.dataArr = arr
                self.navigationController?.pushViewController(vc, animated: true)

            }else if indexPath.row == 3 {
                HCLog(message: "对方当事人情况")
                var arr : [String] = []
                let vc = CasePersionViewController()
                vc.type =  .opposite_detail
                arr.append(dealModel.on)
                arr.append(dealModel.oc)
                arr.append(dealModel.op)
                arr.append(dealModel.oz)
                arr.append(dealModel.oj)
                arr.append(dealModel.oa)
                vc.dataArr = arr
                self.navigationController?.pushViewController(vc, animated: true)

            }else if indexPath.row == 4 {
                HCLog(message: "函件列表")

            }else if indexPath.row == 5 {
                HCLog(message: "收款记录")
                

            }else  {
                HCLog(message: "审核状态")
                var arr : [String] = []
                let vc = CheckInfoViewController()
                arr.append(dealModel.stateStr)
                arr.append(dealModel.admin)
                arr.append(dealModel.applytime)
                vc.dataArr = arr
                self.navigationController?.pushViewController(vc, animated: true)

            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 20
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 20))
        view.backgroundColor = viewBackColor
        return view
    }
    func requestSucceed_work(data: Any, type: WorkRequestVC_enum) {
        if type == .getinfo {
            dealModel = data as! getinfoDealModel
            sectionContent.append(dealModel.dealsnum)
            sectionContent.append(dealModel.typeStr)
            sectionContent.append(dealModel.n)
            sectionContent.append(dealModel.dealpaylasttime)
            sectionContent.append(dealModel.amount)



            
            self.mainTabelView.reloadData()
        } else if type == .dealdel  {
            self.sucessBlock()
            self.navigationController?.popViewController(animated: true)
        }


    }

    func requestFail_work() {

    }

    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    override func navigationRightBtnClick() {
        alertController = UIAlertController(title: nil, message: "", preferredStyle: .actionSheet)
        if self.dealModel.state == 1 {
            //审核合同过只能申请结案
            let actcion1 = UIAlertAction(title: "申请结案", style: .default) { (aciton) in
                self.showAlert(typeNum: 1)
            }
            alertController.addAction(actcion1)

        } else {
            let actcion1 = UIAlertAction(title: "删除", style: .default) { (aciton) in
                self.showAlert(typeNum: 2)
            }
            alertController.addAction(actcion1)

        }
        let actcion2 = UIAlertAction(title: "取消", style: .cancel) { (aciton) in
            self.alertController.dismiss(animated: true, completion: {

            })
        }

        alertController.addAction(actcion2)
        self.present(alertController, animated: true, completion: nil)
    }

    func showAlert(typeNum : Int) {
        var titleStr = ""
        if typeNum == 1 {
            titleStr = "是否确定申请结案"
        } else {
            titleStr = "是否确定删除本条记录"
        }
        alertController = UIAlertController(title: nil, message: titleStr, preferredStyle: .alert)
        let actcion1 = UIAlertAction(title: "确定", style: .default) { (aciton) in
            if typeNum == 1 {
                HCLog(message: "结案")
                let vc = OverCaseViewController()
                vc.dealId = self.dealModel.id
                vc.dealNum = self.dealModel.dealsnum
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                HCLog(message: "删除")
                self.requestVC.dealdelRequest(id: self.dealID)
            }
        }
        let actcion2 = UIAlertAction(title: "取消", style: .cancel) { (aciton) in
            self.alertController.dismiss(animated: true, completion: {

            })
        }
        alertController.addAction(actcion1)
        alertController.addAction(actcion2)
        self.present(alertController, animated: true, completion: nil)

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
