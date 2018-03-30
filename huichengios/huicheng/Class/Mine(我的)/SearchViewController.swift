//
//  SearchViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/30.
//  Copyright © 2018年 lvxin. All rights reserved.
//  搜索

import UIKit
enum SearchViewController_type {
    case expense_type
}
let Searchcell_expenseID = "Searchcell_expense_id"

class SearchViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    /// 列表
    let mainTabelView : UITableView = UITableView()
//    类型
    var type : SearchViewController_type!
//   行数
    var rowNum : Int!
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
        if type == .expense_type {
            self.navigation_title_fontsize(name: "报销查询", fontsize: 18)
            rowNum = 1
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
        if type == .expense_type {
            mainTabelView.register(UINib.init(nibName: "SearchStateTableViewCell", bundle: nil), forCellReuseIdentifier: Searchcell_expenseID)
        }
        self.view.addSubview(mainTabelView)
    }
    
    // MARK: - delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowNum
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : SearchStateTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: Searchcell_expenseID, for: indexPath) as! SearchStateTableViewCell

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if type == .expense_type {
            return CGFloat(50)
        } else {
            return 0
        }
        
    }
    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
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
