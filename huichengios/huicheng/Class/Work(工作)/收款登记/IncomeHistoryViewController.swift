//
//  IncomeHistoryViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/7/20.
//  Copyright © 2018年 lvxin. All rights reserved.
//  收款历史

import UIKit

class IncomeHistoryViewController:  BaseViewController,UITableViewDataSource,UITableViewDelegate {

    let mainTabelView : UITableView = UITableView()
    var dataModelArr : [Income_getlistModel] = []


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
        self.navigation_title_fontsize(name: "合同查询", fontsize: 18)
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
        mainTabelView.register(UINib.init(nibName: "DocTableViewCell", bundle: nil), forCellReuseIdentifier: DocTableViewCellID)
        self.view.addSubview(mainTabelView)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataModelArr.count

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : DocTableViewCell  = tableView.dequeueReusableCell(withIdentifier: DocTableViewCellID, for: indexPath) as! DocTableViewCell
        if indexPath.row < dataModelArr.count {
            let model = dataModelArr[indexPath.row]
            cell.setData_incomeHistory(model: model)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DocTableViewCellH
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
