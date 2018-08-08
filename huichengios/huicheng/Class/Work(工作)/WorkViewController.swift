//
//  WorkViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/5.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let firstH = CGFloat(140)
let wotldFirstCellId = "wotldFirstCell_Id"

class WorkViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,WorkFirstTableViewCellDelegate {
    /// 列表
    let mainTabelView : UITableView = UITableView()
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
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "mes_logo"))
        self.navigation_title_fontsize(name: "工作", fontsize: 18)
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
        mainTabelView.register(UINib.init(nibName: "WorkFirstTableViewCell", bundle: nil), forCellReuseIdentifier: wotldFirstCellId)
        
        //        footer.setRefreshingTarget(self, refreshingAction: #selector(HomeViewController.loadMoreData))
        //        header.setRefreshingTarget(self, refreshingAction: #selector(HomeViewController.freshData))
        //        mainTabelView.mj_footer = footer
        //        mainTabelView.mj_header = header
        //        mainTabelView.register(MessageTableViewCell.self, forCellReuseIdentifier: MESSAGEID)
        //        mainTabelView.register(TeachTableViewCell.self, forCellReuseIdentifier: TEACHCELLID)
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
        let cell : WorkFirstTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: wotldFirstCellId, for: indexPath) as! WorkFirstTableViewCell
        cell.delegate = self
        cell.setData(rowNum: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 4{
            return firstH
        } else {
            return 215
        }
    }
    
    func workFirstTableViewCellBtnClick(tag: Int, rowNum:Int) {
        if rowNum == 0 {
            HCLog(message: "案件")
            switch tag {
            case 0:
                HCLog(message: "案件登记")
                let vc = CaseDetailViewController()
                vc.type = .addCase
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            case 1:
                HCLog(message: "案件管理")
                let vc = CaseViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)

            case 2:
                HCLog(message: "利益冲突")
                let vc = CheckcaseViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)

            case 3:
                HCLog(message: "暂无")
            default:
                HCLog(message: "暂无")
            }
        } else if rowNum == 1 {
            HCLog(message: "合同")
//            "合同管理","结案申请","合同审核","结案审核","审核进度查询"
            switch tag {
            case 0:
                HCLog(message: "合同管理")
                let vc = DealViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)

            case 1:
                HCLog(message: "合同审核")
                let vc = DealCheckViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            case 2:
                HCLog(message: "结案审核")
                let vc = CaseCheckViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            case 3:
                  HCLog(message: "审核查询")
                  let vc = DealSearchViewController()
                  vc.hidesBottomBarWhenPushed = true
                  self.navigationController?.pushViewController(vc, animated: true)
            default:
                HCLog(message: "暂无")
            }
        } else if rowNum == 2{
            switch tag {
            case 0:
                HCLog(message: "函件管理")
                let vc = DocViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            case 1:
                HCLog(message: "诉讼函")
                let vc = CrtDealslistViewController()
                vc.viewType = .type1
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)

            case 2:
                HCLog(message: "非诉函")
                let vc = CrtDealslistViewController()
                vc.viewType = .type2
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            case 3:
                HCLog(message: "刑事函")
                let vc = CrtDealslistViewController()
                vc.viewType = .type3
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            case 4:
                HCLog(message: "法律函")
                let vc = CrtDealslistViewController()
                vc.viewType = .type4
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            case 5:
                HCLog(message: "函件查询")
                let vc = DocSearchViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            case 6:
                HCLog(message: "函件审核")
                let vc = DocApplylistViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)


            default:
                HCLog(message: "暂无")
            }
        } else if rowNum == 3{
            HCLog(message: "财务")
//            "收款登记","收款审核","支付收款","支付审核","报销审核","发票审核","签章审核"
            switch tag {
            case 0:
                HCLog(message: "收款登记")
                let vc : IncomeListViewController = IncomeListViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)

            case 1:
                HCLog(message: "收款审核")
            case 2:
                HCLog(message: "支付收款")
            case 3:
                HCLog(message: "支付审核")
            case 4:
                HCLog(message: "报销审核")
                let vc = ExpenseapplylistViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            case 5:
                HCLog(message: "发票审核")
                let vc = InvoiceapplylisViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            case 6:
                HCLog(message: "银行信息")
                let vc = BankInfoViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                HCLog(message: "暂无")
            }
        } else {
            HCLog(message: "其他")
//                let labelNameAr4 = ["会议室预约","发布公告","共享模板",]
            switch tag {
            case 0:
                HCLog(message: "会议室预约")
                let vc = RoomViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            case 1:
                HCLog(message: "发布公告")
                let vc = NoticeViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 2:
                HCLog(message: "共享模板")
                let vc = ShareViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                HCLog(message: "暂无")
            }
        }

    }
    // MARK: - event response
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
