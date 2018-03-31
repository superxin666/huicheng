//
//  ConvenViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/5.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let ConVenTableViewCellID = "ConVenTableViewCell_ID"
let ConVenTableViewCellH = CGFloat(100)
class ConvenViewController: BaseViewController,ConbenTopViewDelegate,UITableViewDelegate,UITableViewDataSource,ConvenRequestVCDelegate {
    var topView : ConbenTopView!
    /// 列表
    let mainTabelView : UITableView = UITableView()
    let request : ConvenRequestVC = ConvenRequestVC()
    /// 数据 数组
    var dataArr : [quick_getlistModel] = []
    
    var pageNum : Int = 1
    
    /// 默认 1 法院
    var type : Int = 1
    
    
    // MARK: - life circle
    override func viewWillLayoutSubviews() {
        topView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(LNAVIGATION_HEIGHT+0.5)
            make.left.right.equalTo(self.view).offset(0)
            make.height.equalTo(40)
        }
        mainTabelView.snp.makeConstraints { (make) in
            make.top.equalTo(topView).offset(40)
            make.left.right.equalTo(self.view).offset(0)
            make.bottom.equalTo(self.view).offset(0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = viewBackColor
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "mes_logo"))
        self.navigationBar_rightBtn_image(image:#imageLiteral(resourceName: "mine_search"))
        self.navigation_title_fontsize(name: "便捷", fontsize: 18)
        topView = ConbenTopView.loadNib()
        topView.delegate  = self
        self.view.addSubview(topView)
        self.creatUI()
        request.delegate = self
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
        mainTabelView.register(UINib.init(nibName: "ConVenTableViewCell", bundle: nil), forCellReuseIdentifier: ConVenTableViewCellID)
//        mainTabelView.mj_footer = self.creactFoot()
//        mainTabelView.mj_footer.setRefreshingTarget(self, refreshingAction: #selector(loadMoreData))
//        mainTabelView.mj_header = header
//        header.setRefreshingTarget(self, refreshingAction: #selector(reflishData))

        self.view.addSubview(mainTabelView)
    }
    
    // MARK: - delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ConVenTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: ConVenTableViewCellID, for: indexPath) as! ConVenTableViewCell
        if indexPath.row < self.dataArr.count {
            let model = self.dataArr[indexPath.row]
            cell.setData(model: model)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ConVenTableViewCellH
    }
    //net
    func requestSucceed(data: Any, type: ConvenRequestVC_enum) {
        let arr  = data as! [quick_getlistModel]
        if arr.count > 0 {
            if pageNum > 1 {
                self.dataArr = arr + self.dataArr
            } else {
                self.dataArr = arr
            }
        } else {
            if pageNum > 1 {
                SVPMessageShow.showErro(infoStr: "已经加载全部内容")
            } else {
                SVPMessageShow.showErro(infoStr: "暂无内容")
            }
        }
        mainTabelView.reloadData()
    }
    func requestFail() {
        
    }
    // MARK: - net
    func requestApi() {
        request.quick_getlistRequest(t: type, kw: "")
    }
    //加载更多
    @objc func loadMoreData()  {
        pageNum = pageNum + 1
        self.requestApi()
        
    }
    //刷新
    @objc func reflishData() {
        pageNum = 1
        if self.dataArr .count > 0 {
            self.dataArr.removeAll()
        }
        self.requestApi()
    }
    
    // MARK: - delegate
    func btnClick(tag: Int) {
        switch tag {
        case 0:
            HCLog(message: "法院")
            type = 1
        case 1:
            HCLog(message: "检察院")
            type = 2
        case 2:
            HCLog(message: "公安机关")
            type = 3
        case 3:
            HCLog(message: "仲裁委")
            type = 4
        case 4:
            HCLog(message: "看守所")
            type = 5
        default:
            HCLog(message: "没有")
        }
        if self.dataArr.count > 0 {
            self.dataArr.removeAll()
        }
        self.requestApi()
        
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
