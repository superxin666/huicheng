
//
//  DealDetailViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/4/20.
//  Copyright © 2018年 lvxin. All rights reserved.
//  合同详情

import UIKit
typealias DealDetailViewControllerBlcok = ()->()
enum DealDetailViewControllerType {
    case searchDeal,deallist
}

class DealDetailViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,WorkRequestVCDelegate {

    var type : DealDetailViewControllerType = .deallist


    var sucessBlock : DealDetailViewControllerBlcok!

    let mainTabelView : UITableView = UITableView()
    let requestVC = WorkRequestVC()
    var sectionNameArr = ["合同编号","案件类型","案件名称","合同付款期限","合同总款","合同扫描件"]
    var sectionNameArr2 = ["合同编号","案件类型","案件名称","合同付款期限","合同有效期","合同总款","合同扫描件"]
    var currectsectionNameArr2 : [String] = []

    var sectionContent:[String] = []


    var section2NameArr = ["发票信息","基本情况","委托人情况","对方当事人情况","函件列表","收款记录","审核状态"]
    var dealID : Int!
    var alertController : UIAlertController!

    /// 数据模型
    var dealModel : getdetailModel!


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
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        currectsectionNameArr2 = sectionNameArr
        self.creatUI()
        requestVC.delegate = self
        SVPMessageShow.showLoad()
//        requestVC.dealgetinfo(id: dealID)
        requestVC.getdetail(id: dealID)

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
            return currectsectionNameArr2.count
        } else {
            return section2NameArr.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 5 {
                let cell : Title2TableViewCell  = tableView.dequeueReusableCell(withIdentifier: Title2TableViewCellID, for: indexPath) as! Title2TableViewCell
                cell.setData(titleStr: currectsectionNameArr2[indexPath.row])
                return cell
            } else {
                let cell : Title3TableViewCell  = tableView.dequeueReusableCell(withIdentifier: Title3TableViewCellID, for: indexPath) as! Title3TableViewCell
                var str = ""
                if indexPath.row < sectionContent.count {
                    str = sectionContent[indexPath.row]
                }
                cell.setData_deal(titleStr: currectsectionNameArr2[indexPath.row], contentStr: str)
                return cell
            }
        } else {
            let cell : Title2TableViewCell  = tableView.dequeueReusableCell(withIdentifier: Title2TableViewCellID, for: indexPath) as! Title2TableViewCell
            cell.setData(titleStr: section2NameArr[indexPath.row])
            return cell

        }

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 5 {
                if type == .deallist{
                    //查看函件
                    let vc = ReadPdfViewController()

                    vc.url = URL(string: base_imageOrFile_api + self.dealModel.data.img!)
                    vc.titleStr = "扫描件"
                    self.navigationController?.pushViewController(vc, animated: true)

                    
                }
            }
        }


        if indexPath.section == 1 {
//             ["发票信息","基本情况","委托人情况","对方当事人情况","函件列表","收款记录","审核状态"]
            let nameStr : String = section2NameArr[indexPath.row]
            switch nameStr {
            case "发票信息" :
                HCLog(message: "发票信息")
                let vc = invoiceInfoViewController()
                vc.hidesBottomBarWhenPushed = true
                var arr : [String] = []
                // ["发票情况","发票信息","社会统一代码","发票内容",]

                arr.append(dealModel.data.ispaperStr)
                arr.append(dealModel.data.paper)
                arr.append(dealModel.data.creditcode)

                arr.append(dealModel.data.invoicetypeStr)

                vc.dataArr = arr
                self.navigationController?.pushViewController(vc, animated: true)
            case "基本情况" :
                HCLog(message: "基本情况")
                var arr : [String] = []
                var arr2 : [String] = []
                let vc = BaseInfoViewController()

                arr.append(dealModel.data.rStr)
                arr.append(dealModel.data.rt)
                arr.append(dealModel.data.w1Str)
                arr.append(dealModel.data.w2Str)
                arr.append(dealModel.data.dStr)

                arr2.append(dealModel.data.ct)
                arr2.append(dealModel.data.sj)

                vc.dataArr = arr
                vc.dataArr2 = arr2
                vc.section1titleArr = ["立案律师","立案日期","承办律师","承办律师","案件组别"]
                if dealModel.data.type == 4 || dealModel.data.type == 2 {
                    vc.section2titleArr =   ["案件自述"]
                }
                self.navigationController?.pushViewController(vc, animated: true)
            case "委托人情况" :
                HCLog(message: "委托人情况")
                var arr : [String] = []
                //委托人情况
                let vc = CasePersionViewController()
                vc.type =  .principal_detail
                HCLog(message: dealModel.data.type)
                vc.caseType = "\(dealModel.data.type!)"
                if dealModel.data.type == 4  {
                    arr.append(dealModel.data.pn)
                    arr.append(dealModel.data.pc)
                    arr.append(dealModel.data.pp)
                    arr.append(dealModel.data.pz)
                    arr.append(dealModel.data.pj)
//                    arr.append(dealModel.data.pd)
                    arr.append(dealModel.data.pa)
                } else {
                    arr.append(dealModel.data.pn)
                    arr.append(dealModel.data.pc)
                    arr.append(dealModel.data.pp)
                    arr.append(dealModel.data.pz)
                    arr.append(dealModel.data.pj)
                    arr.append(dealModel.data.pd)
                    arr.append(dealModel.data.pa)

                }

                vc.dataArr = arr
                self.navigationController?.pushViewController(vc, animated: true)

            case "对方当事人情况" :
                HCLog(message: "对方当事人情况")
                var arr : [String] = []
                let vc = CasePersionViewController()
                vc.type =  .opposite_detail
                arr.append(dealModel.data.on)
                arr.append(dealModel.data.oc)
                arr.append(dealModel.data.op)
                arr.append(dealModel.data.oz)
                arr.append(dealModel.data.oj)
                arr.append(dealModel.data.oa)
                vc.dataArr = arr
                self.navigationController?.pushViewController(vc, animated: true)
            case "函件列表" :
                HCLog(message: "函件列表")
                let vc : DocListViewController = DocListViewController()
                vc.dataArr = self.dealModel.document
                self.navigationController?.pushViewController(vc, animated: true)
            case "收款记录" :
                HCLog(message: "收款记录")
                let vc : IncomeHistoryViewController = IncomeHistoryViewController()
                vc.dataArr = self.dealModel.income
                self.navigationController?.pushViewController(vc, animated: true)
            case "审核状态" :
                HCLog(message: "审核状态")
                var arr : [String] = []
                let vc = CheckInfoViewController()
                arr.append(dealModel.data.stateStr)
                arr.append(dealModel.data.admin)
                arr.append(dealModel.data.applytime)
                vc.dataArr = arr
                self.navigationController?.pushViewController(vc, animated: true)
            default :
                HCLog(message: "审核状态")

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
        if type == .getdetail {
            SVPMessageShow.dismissSVP()
            dealModel = data as! getdetailModel
             //非诉案件-2  刑事案件-3  法律顾问-4
            if dealModel.data.type == 2 {
                section2NameArr.remove(at: 3)

            } else if dealModel.data.type ==  4{
                section2NameArr.remove(at: 3)


            }
            

            if dealModel.data.type == 4 {
                //法律
                sectionContent.append(dealModel.data.dealsnum)
                sectionContent.append(dealModel.data.typeStr)
                sectionContent.append(dealModel.data.n)
                sectionContent.append(dealModel.data.dealpaylasttime)
                sectionContent.append(dealModel.data.endtime)
                sectionContent.append(dealModel.data.amount)
                currectsectionNameArr2 = sectionNameArr2

            } else {
                sectionContent.append(dealModel.data.dealsnum)
                sectionContent.append(dealModel.data.typeStr)
                sectionContent.append(dealModel.data.n)
                sectionContent.append(dealModel.data.dealpaylasttime)
                sectionContent.append(dealModel.data.amount)
                currectsectionNameArr2 = sectionNameArr


            }

            if self.type == .searchDeal {
                self.navigationBar_rightBtn_title(name: "打印")

            } else {
                self.navigationBar_rightBtn_title(name: "操作")

            }


            self.mainTabelView.reloadData()
        } else if type == .dealdel  || type == .overcancel {
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

        if type == .searchDeal {
            HCLog(message: "分享")

            let vc = ReadPdfViewController()
            vc.url = URL(string: base_imageOrFile_api + self.dealModel.data.img!)
            vc.type = .shareFile
            vc.titleStr = "合同扫描件"
            vc.pdfStr = self.dealModel.data.img!
            self.navigationController?.pushViewController(vc, animated: true)

        } else {

            alertController = UIAlertController(title: nil, message: "", preferredStyle: .actionSheet)
            if self.dealModel.data.state == 1 {
                //审核合同过  申请结案  分享
                let actcion1 = UIAlertAction(title: "申请结案", style: .default) { (aciton) in
                    self.showAlert(typeNum: 1)
                }
                alertController.addAction(actcion1)

                let actcion2 = UIAlertAction(title: "分享", style: .default) { (aciton) in

                    let vc = ReadPdfViewController()
                    vc.url = URL(string: base_imageOrFile_api + self.dealModel.data.img!)
                    vc.type = .shareFile
                    vc.pdfStr = self.dealModel.data.img!
                    vc.titleStr = "合同扫描件"
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                alertController.addAction(actcion2)


            } else if self.dealModel.data.state == 4 {
                //申请结案中 可撤回
                let actcion1 = UIAlertAction(title: "撤回", style: .default) { (aciton) in
                    self.showAlert(typeNum: 4)
                }
                alertController.addAction(actcion1)



            }  else if  self.dealModel.data.state == 0 ||  self.dealModel.data.state == 2 {
                // 未审核
                let actcion1 = UIAlertAction(title: "删除", style: .default) { (aciton) in
                    self.showAlert(typeNum: 2)
                }
                alertController.addAction(actcion1)


                let actcion3 = UIAlertAction(title: "修改", style: .default) { (aciton) in
                    self.showAlert(typeNum: 3)
                }
                alertController.addAction(actcion3)

            }
            

            let actcion2 = UIAlertAction(title: "取消", style: .cancel) { (aciton) in
                self.alertController.dismiss(animated: true, completion: {

                })
            }

            alertController.addAction(actcion2)
            self.present(alertController, animated: true, completion: nil)


        }


    }

    func showAlert(typeNum : Int) {
        var titleStr = ""
        if typeNum == 1 {
            titleStr = "是否确定申请结案"
        } else if typeNum == 2 {
            titleStr = "是否确定删除本条记录"
        } else if typeNum == 3{
            titleStr = "是否确定修改本条记录"

        } else if typeNum == 4 {
            titleStr = "是否确要撤回本条记录"
        }
        alertController = UIAlertController(title: nil, message: titleStr, preferredStyle: .alert)
        let actcion1 = UIAlertAction(title: "确定", style: .default) { (aciton) in
            if typeNum == 1 {
                HCLog(message: "结案")
                let vc = OverCaseViewController()
                vc.dealId = self.dealModel.data.id
                vc.dealNum = self.dealModel.data.dealsnum
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            } else  if typeNum == 2{
                HCLog(message: "删除")
                self.requestVC.dealdelRequest(id: self.dealID)
            } else if typeNum == 3 {
                HCLog(message: "修改")
                let vc : OverDealViewController = OverDealViewController()
                vc.hidesBottomBarWhenPushed = true
                vc.type = .editeDeal
                vc.dealId = self.dealModel.data.id
                vc.dealNum = self.dealModel.data.dealsnum
                vc.dStr = self.dealModel.data.dealpaylasttime
                vc.aStr = self.dealModel.data.amount
                
                vc.itStr = "\(self.dealModel.data.ispaper!)"
                vc.pStr = self.dealModel.data.paper
                vc.ccStr = self.dealModel.data.creditcode

                vc.bStr = self.dealModel.data.begintime
                vc.eStr = self.dealModel.data.endtime
                vc.fileStr = self.dealModel.data.img!
                vc.itIdStr  = "\(self.dealModel.data.invoicetype!)"
                vc.itNameStr  = self.dealModel.data.invoicetypeStr
                vc.caseType = "\(self.dealModel.data.type!)"

                self.navigationController?.pushViewController(vc, animated: true)
            } else if typeNum == 4 {
                //撤回
                HCLog(message: "撤回")
                self.requestVC.dealCancleRequest(id: self.dealID)
                
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
