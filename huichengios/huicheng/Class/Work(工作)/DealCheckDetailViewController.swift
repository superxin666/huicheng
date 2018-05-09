

//
//  DealCheckDetailViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/5/8.
//  Copyright © 2018年 lvxin. All rights reserved.
//  合同审核详情

import UIKit

class DealCheckDetailViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,WorkRequestVCDelegate,SelectedTableViewCellDelegate,ContentTableViewCellDelegate {
    let mainTabelView : UITableView = UITableView()
    let requestVC = WorkRequestVC()
    var dataArr : [dealGetlistModel] = []
    var dealID : Int!




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

        self.navigation_title_fontsize(name: "合同审核", fontsize: 18)
        self.navigationBar_rightBtn_title(name: "保存")
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        self.creatUI()
        self.requestApi()
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
        mainTabelView.register(UINib.init(nibName: "SelectedTableViewCell", bundle: nil), forCellReuseIdentifier: SelectedTableViewCellID)
        mainTabelView.register(UINib.init(nibName: " ContentTableViewCell", bundle: nil), forCellReuseIdentifier: ContentTableViewCellID)
        mainTabelView.register(UINib.init(nibName: " Title4TableViewCell", bundle: nil), forCellReuseIdentifier: Title4TableViewCellID)
        mainTabelView.register(UINib.init(nibName: " Title2TableViewCell", bundle: nil), forCellReuseIdentifier: Title2TableViewCellID)
        self.view.addSubview(mainTabelView)
    }
    // MARK: - delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else if section == 1 {
            return 9
        } else {
            return 2
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell : SelectedTableViewCell  = tableView.dequeueReusableCell(withIdentifier: SelectedTableViewCellID, for: indexPath) as! SelectedTableViewCell
                cell.setData_dealcheckdetail()
                return cell
            } else {

                let cell : ContentTableViewCell  = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCellID, for: indexPath) as! ContentTableViewCell
                cell.delegate = self
                cell.setData_overdeal(titleStr: "驳回原因")
                return cell
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 7 {
                let cell : ContentTableViewCell  = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCellID, for: indexPath) as! ContentTableViewCell
                cell.setData_dealcheckdetail(title: "案件自述", contentCase: "123")
                return cell
            } else if indexPath.row == 8 {
                let cell : Title2TableViewCell  = tableView.dequeueReusableCell(withIdentifier: Title2TableViewCellID, for: indexPath) as! Title2TableViewCell
                cell.setData(titleStr: "合同扫描件")
                return cell
            } else {
                let cell : Title4TableViewCell  = tableView.dequeueReusableCell(withIdentifier: Title4TableViewCellID, for: indexPath) as! Title4TableViewCell
                cell.setData_overCase(titleStr: "12", contentStr: "34")
                return cell
            }
        } else {
            let cell : Title2TableViewCell  = tableView.dequeueReusableCell(withIdentifier: Title2TableViewCellID, for: indexPath) as! Title2TableViewCell
            cell.setData(titleStr: "合同扫描件")
            return cell
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            return view
        } else if section == 1 {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 40))
            view.backgroundColor = viewBackColor

            let label = UILabel(frame: CGRect(x: 10, y: 10, width: 100, height: 20))
            view.addSubview(label)
            label.font = hc_fontThin(15)
            label.text = "合同信息"
            label.textColor = UIColor.hc_colorFromRGB(rgbValue: 0x333333)
            return view
        }  else {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 20))
            view.backgroundColor = viewBackColor
            return view
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else if section == 1 {
            return 40
        } else {
            return 20
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 1 {
                return ContentTableViewCellH
            } else {
                return 50
            }
        }  else if indexPath.section == 1 {
            if indexPath.row == 8 {
                return ContentTableViewCellH
            } else {
                return 50
            }
        } else {
            return 50
        }

    }

    func selectedClickDelegate_type(tag: Int, type: String) {

    }

    func endText_content(content: String) {

    }

    // MARK: - net
    func requestApi() {
    }


    func requestSucceed_work(data: Any,type : WorkRequestVC_enum) {

    }

    func requestFail_work() {

    }


    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    override func navigationRightBtnClick() {
        HCLog(message: "保存")

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
