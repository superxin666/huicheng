

//
//  DocSearchViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/8/4.
//  Copyright © 2018年 lvxin. All rights reserved.
// 函件查询

import UIKit

class DocSearchViewController: BaseViewController ,UITableViewDataSource,UITableViewDelegate,Work2RequestVCDelegate {
    let mainTabelView : UITableView = UITableView()
    let requestVC = Work2RequestVC()
    var dataArr : [docgetlistModel] = []
    var pageNum : Int = 1

    /// 分所id
    var bidStr = ""
    /// 函件编号
    var dnStr = ""
    /// 合同编号
    var nStr = ""
    /// 申请人
    var kwStr = ""
    /// 律师名称
    var uStr = ""
    /// 案件名称
    var cnStr = ""
    /// 开始时间
    var bStr = ""
    /// 结束时间
    var eStr = ""



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

        self.navigation_title_fontsize(name: "函件查询", fontsize: 18)
        self.navigationBar_rightBtn_image(image: #imageLiteral(resourceName: "mine_search"))
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
        mainTabelView.register(UINib.init(nibName: "DocTableViewCell", bundle: nil), forCellReuseIdentifier: DocTableViewCellID)
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
        let cell : DocTableViewCell  = tableView.dequeueReusableCell(withIdentifier: DocTableViewCellID, for: indexPath) as! DocTableViewCell
        if indexPath.row < self.dataArr.count {
            let model : docgetlistModel = self.dataArr[indexPath.row]
            cell.setData_docSearch(model: model)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row  < self.dataArr.count {
            let model : docgetlistModel = self.dataArr[indexPath.row]
            requestVC.docgetinfoRequset(id: "\(model.id!)")

        }

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DocTableViewCellH
    }
    // MARK: - net
    func requestApi() {
        requestVC.delegate = self
        requestVC.doc_searchReuqest(dn: self.dnStr, bid: self.bidStr, n: self.nStr, kw: self.kwStr, u: self.uStr, cn: self.cnStr, b: self.bStr, e: self.eStr)
    }

    func reflishData() {
        if self.dataArr.count > 0 {
            self.dataArr.removeAll()
        }
        pageNum = 1
        self.requestApi()
    }

    func requestSucceed_work2(data: Any, type: Work2RequestVC_enum) {
        if type == .doc_search {
            let arr : [docgetlistModel] = data as! [docgetlistModel]
            self.dataArr = arr
            self.mainTabelView.reloadData()
        } else if type == .doc_getinfo {
            let model : docgetinfoModel = data as! docgetinfoModel
            let vc = ReadPdfViewController()
            
            vc.url = URL(string: base_imageOrFile_api + model.pdf!)
            self.navigationController?.pushViewController(vc, animated: true)

//            let filePath = model.pdf!.components(separatedBy: "/")
//            let fileName = filePath.last
//            HCLog(message: filePath)
//            HCLog(message: fileName)
//
//            let baseVC = BaseNetViewController()
////            let url = base_imageOrFile_api + model.pdf!
//
//            baseVC.downLoadFile(path: model.pdf!, name: fileName!, completion: { (data) in
//                let urlStr : String = data as! String
//                let vc : ReadFileViewController = ReadFileViewController()
//                vc.fileUrl = urlStr
//                vc.jump(vc: self)
//            }) { (erro) in
//                SVPMessageShow.showErro(infoStr: "文件加载失败，请重新尝试")
//            }

        }

    }


    func requestFail_work2() {

    }


    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    override func navigationRightBtnClick() {
        HCLog(message: "搜索")
        let vc = SearchViewController()
        vc.type = .doc_search
        weak var weakself = self
        vc.sureDocSearchSure = {(nStr,dnStr,kwStr,uStr,cnStr,bidStr,startTimeStr,endTimeStr) in

            HCLog(message: startTimeStr)
            HCLog(message: endTimeStr)

            weakself?.nStr = nStr
            weakself?.dnStr = dnStr
            weakself?.kwStr = kwStr
            weakself?.uStr = uStr
            weakself?.cnStr = cnStr
            weakself?.bidStr = bidStr
            weakself?.bStr = startTimeStr
            weakself?.eStr = endTimeStr
            weakself?.reflishData()
        }
        self.navigationController?.pushViewController(vc, animated: true)


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
