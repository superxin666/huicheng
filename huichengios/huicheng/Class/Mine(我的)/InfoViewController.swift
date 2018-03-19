//
//  InfoViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/18.
//  Copyright © 2018年 lvxin. All rights reserved.
//  个人信息

import UIKit
let INFOID = "INFO_ID"
let INFOID_first = "INFO_first_ID"
let info_cell_height = CGFloat(50)
class InfoViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    var model : user_getinfoModel!
    
    /// 列表
    let mainTabelView : UITableView = UITableView()
    let nameArr = ["头像","姓名","账号","部门","职位","执业证号","手机号码","更多"]
    var contentArr : [String] = []

    
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
        self.navigationBar_rightBtn_title(name: "编辑")
        self.navigation_title_fontsize(name: "个人信息", fontsize: 18)
        self.creatUI()
        contentArr.append(model.face)
        contentArr.append(model.name)
        contentArr.append(model.username)
        contentArr.append(model.department)
        contentArr.append(model.role)
        contentArr.append("后台没有返回")
        contentArr.append(model.mobile)
        contentArr.append("更多")
        
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
        mainTabelView.register(UINib.init(nibName: "InfoTableViewCell", bundle: nil), forCellReuseIdentifier: INFOID)
        mainTabelView.register(UINib.init(nibName: "InfoFirstTableViewCell", bundle: nil), forCellReuseIdentifier: INFOID_first)
        
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
        return 8
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell : InfoFirstTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: INFOID_first, for: indexPath) as! InfoFirstTableViewCell

            return cell
        } else {
            let cell : InfoTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: INFOID, for: indexPath) as! InfoTableViewCell
                cell.setData(titleStr: nameArr[indexPath.row], contentStr: contentArr[indexPath.row])
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            HCLog(message: "选择头像")
        } else {
            HCLog(message: "其他")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return info_cell_height + 30.0
        } else {
            return info_cell_height
        }
        
    }
    
    // MARK: - event response
    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    override func navigationRightBtnClick() {
        HCLog(message: "编辑")
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
