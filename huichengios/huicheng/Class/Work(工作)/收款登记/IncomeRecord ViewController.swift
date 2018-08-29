//
//  IncomeRecord ViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/7/21.
//  Copyright © 2018年 lvxin. All rights reserved.
//  收款记录

import UIKit
enum IncomeRecord_ViewControllerType {
    case add_history,list_history
}
class IncomeRecord_ViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate {

    let mainTabelView : UITableView = UITableView()
    //详情列表 历史
    var dataModelArr : [Income_getlistModel] = []
    //添加记录 历史
    var dataModelArr2 : [Income_getlistModel] = []

    var type : IncomeRecord_ViewControllerType!


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
        self.navigation_title_fontsize(name: "收款记录", fontsize: 18)
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
        mainTabelView.register(UINib.init(nibName: "IncomeRecordTableViewCell", bundle: nil), forCellReuseIdentifier: IncomeRecordTableViewCellID)
        self.view.addSubview(mainTabelView)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if type == .add_history {
            return dataModelArr2.count
        } else {
            return self.dataModelArr.count
        }

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : IncomeRecordTableViewCell  = tableView.dequeueReusableCell(withIdentifier: IncomeRecordTableViewCellID, for: indexPath) as! IncomeRecordTableViewCell
        if type == .add_history {
            if indexPath.row < self.dataModelArr2.count {
                let model = self.dataModelArr2[indexPath.row]
                cell.setData_add(model: model)
            }
        }
        return cell
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return IncomeRecordTableViewCellH


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
