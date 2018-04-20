
//
//  DealDetailViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/4/20.
//  Copyright © 2018年 lvxin. All rights reserved.
//  合同详情

import UIKit

class DealDetailViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,WorkRequestVCDelegate {
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
        dealModel = data as! getinfoDealModel
        sectionContent.append(dealModel.dealsnum)
        sectionContent.append(dealModel.typeStr)
        sectionContent.append(dealModel.n)
        sectionContent.append(dealModel.dealpaylasttime)
        sectionContent.append(dealModel.amount)
        self.mainTabelView.reloadData()

    }

    func requestFail_work() {

    }

    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    override func navigationRightBtnClick() {
        alertController = UIAlertController(title: nil, message: "", preferredStyle: .actionSheet)
        let actcion1 = UIAlertAction(title: "申请结案", style: .default) { (aciton) in
            let vc = OverCaseViewController()
            vc.dealId = self.dealModel.id
            vc.dealNum = self.dealModel.dealsnum
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
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
