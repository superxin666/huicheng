//
//  MoreInfoViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/19.
//  Copyright © 2018年 lvxin. All rights reserved.
//  更多信息

import UIKit

class MoreInfoViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    var model : user_getinfoModel!

    /// 列表
    let mainTabelView : UITableView = UITableView()
    let nameArr = ["性别","学历","籍贯","政治面貌","入职时间","身份证号","我的地址"]
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
        self.navigation_title_fontsize(name: "个人信息", fontsize: 18)
        
        contentArr.append(model.sex)
        contentArr.append(model.diploma)
        contentArr.append(model.hometown)
        contentArr.append(model.political)
        contentArr.append(model.intime)
        contentArr.append(model.idcard)
        contentArr.append(model.addr)
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
        mainTabelView.register(UINib.init(nibName: "InfoTableViewCell", bundle: nil), forCellReuseIdentifier: INFOID)

        self.view.addSubview(mainTabelView)
    }
    
    // MARK: - delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell : InfoTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: INFOID, for: indexPath) as! InfoTableViewCell
            cell.setData(titleStr: nameArr[indexPath.row], contentStr: contentArr[indexPath.row])
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return info_cell_height
    }
    
    // MARK: - event response
    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
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
