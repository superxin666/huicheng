//
//  CheckcaseViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/31.
//  Copyright © 2018年 lvxin. All rights reserved.
//  利益冲突检查

import UIKit

class CheckcaseViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate {
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
        
        self.navigation_title_fontsize(name: "利益冲突检查", fontsize: 18)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        self.navigationBar_rightBtn_title(name: "确定")
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
        mainTabelView.register(UINib.init(nibName: "CheckcaseTableViewCell", bundle: nil), forCellReuseIdentifier: CheckcaseTableViewCellID)

        self.view.addSubview(mainTabelView)
    }
    // MARK: - delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CheckcaseTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: CheckcaseTableViewCellID, for: indexPath) as! CheckcaseTableViewCell
        if indexPath.row == 0 {
            cell.setData(titleStr: "关系人", rowTag: 0)
        } else {
            cell.setData(titleStr: "关系人身份证号码", rowTag: 1)
        }
        return cell
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
