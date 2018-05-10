//
//  CheckInfoViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/5/10.
//  Copyright © 2018年 lvxin. All rights reserved.
//  审核情况

import UIKit

class CheckInfoViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource {
    var sucessBlock : DealDetailViewControllerBlcok!

    let mainTabelView : UITableView = UITableView()
    var sectionNameArr = ["状态","审核人","审核时间",]
    var dataArr:[String] = []


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
        self.navigation_title_fontsize(name: "审核情况", fontsize: 18)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
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

        mainTabelView.register(UINib.init(nibName: "Title3TableViewCell", bundle: nil), forCellReuseIdentifier: Title3TableViewCellID)

        self.view.addSubview(mainTabelView)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell : Title3TableViewCell  = tableView.dequeueReusableCell(withIdentifier: Title3TableViewCellID, for: indexPath) as! Title3TableViewCell
        var str = ""
        if indexPath.row < dataArr.count {
            str = dataArr[indexPath.row]
        }
        cell.setData_deal(titleStr: sectionNameArr[indexPath.row], contentStr: str)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

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
