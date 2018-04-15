//
//  CasePersionViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/4/13.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
enum CasePersionViewControllertype {
    //委托人                              对方当事人
    case principal_detail,principal_add, opposite_detail,opposit_add
}
class CasePersionViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate,TitleTableViewCellDelegate {
    var type  : CasePersionViewControllertype!
    var nameArr : [String] = ["委托人","联系人","电话","邮编","职务","身份证号","联系地址",]
    var dataArr : Array<String>!


    let mainTabelView : UITableView = UITableView()
    let request : WorkRequestVC = WorkRequestVC()

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
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        if type == .principal_detail {
            self.navigation_title_fontsize(name: "委托人情况", fontsize: 18)

        } else if type == .principal_add {
            self.navigation_title_fontsize(name: "委托人情况", fontsize: 18)
            self.navigationBar_rightBtn_title(name: "确定")

        } else if type == .opposite_detail {
            self.navigation_title_fontsize(name: "对方当事人情况", fontsize: 18)
            nameArr.remove(at: 5)

        } else{
            self.navigation_title_fontsize(name: "对方当事人情况", fontsize: 18)
            self.navigationBar_rightBtn_title(name: "确定")
            nameArr.remove(at: 5)
        }



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
    // MARK: - delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArr.count

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : TitleTableViewCell  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
        cell.delegate = self
        if indexPath.row < dataArr.count {
            cell.setData_caseDetail(titleStr: nameArr[indexPath.row], contentStr: dataArr[indexPath.row],indexPath : indexPath)
        }
        cell.tag = indexPath.row
        if type == .principal_detail || type == .opposite_detail{
            cell.isUserInteractionEnabled = false
        } else {
            cell.isUserInteractionEnabled = true
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TitleTableViewCellH
    }


    func endEdite(inputStr: String, tagNum: Int) {
        HCLog(message: inputStr)
        HCLog(message: tagNum)
    }

    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    override func navigationRightBtnClick() {
        HCLog(message: "确定")
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
