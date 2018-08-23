//
//  CrtGetinfoViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/8/9.
//  Copyright © 2018年 lvxin. All rights reserved.
//  获取类型格式

import UIKit

class CrtGetinfoViewController:  BaseTableViewController,Work2RequestVCDelegate,TitleTableViewCellDelegate,ContentTableViewCellDelegate,OptionViewDelgate,DatePickViewDelegate {
    let mainTabelView : UITableView = UITableView()
    let requestVC = Work2RequestVC()


    var id : Int!
    var docID : Int!
    var dataModel : CrtGetinfoModel!
    var itemsArr : [CrtGetinfoModel_items] = []

    var iconImageView : UIImageView = UIImageView(frame: CGRect(x: ip6(10), y: ip6(50), width: KSCREEN_WIDTH - ip6(20), height: KSCREEN_HEIGHT - ip6(100)))


    var closeBtn : UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: ip6(50), height: ip6(50)))



    /// 选项
    let optionView : OptionView = OptionView.loadNib()
    /// 时间
    var timeView : DatePickView = DatePickView.loadNib()

    // MARK: - life
    override func viewWillLayoutSubviews() {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = viewBackColor
        self.navigation_title_fontsize(name: "生成函件", fontsize: 18)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        self.navigationBar_rightBtn_title(name: "确定")

        self.creatUI()
        self.requestApi()
    }
    // MARK: - UI
    func creatUI() {
//        mainTabelView.backgroundColor = UIColor.clear
        mainTabelView.delegate = self;
        mainTabelView.dataSource = self;
        mainTabelView.tableFooterView = UIView()
        mainTabelView.separatorStyle = .none
        mainTabelView.showsVerticalScrollIndicator = false
        mainTabelView.showsHorizontalScrollIndicator = false
        mainTabelView.backgroundView?.backgroundColor = .clear
        mainTabelView.register(UINib.init(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: TitleTableViewCellID)
        mainTabelView.register(UINib.init(nibName: "endTimeTableViewCell", bundle: nil), forCellReuseIdentifier: endTimeTableViewCellid)
        mainTabelView.register(UINib.init(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: OptionTableViewCellID)
        mainTabelView.register(UINib.init(nibName: "Title4TableViewCell", bundle: nil), forCellReuseIdentifier: Title4TableViewCellID)
        mainTabelView.register(UINib.init(nibName: "ContentTableViewCell", bundle: nil), forCellReuseIdentifier: ContentTableViewCellID)
        mainTabelView.register(UINib.init(nibName: "CrtGetinfoImageTableViewCell", bundle: nil), forCellReuseIdentifier: CrtGetinfoImageTableViewCellID)


        self.tableView = mainTabelView
//        self.view.addSubview(mainTabelView)
    }
    // MARK: - delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return itemsArr.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if itemsArr.count > 0 && indexPath.row < itemsArr.count {

            if indexPath.section == 0 {
                let cell : CrtGetinfoImageTableViewCell  = tableView.dequeueReusableCell(withIdentifier: CrtGetinfoImageTableViewCellID, for: indexPath) as! CrtGetinfoImageTableViewCell
                cell.setData(titleStr: dataModel.deals.casename!, imageStr: dataModel.deals.docimg!)
                cell.imageBlock = {
                    self.showBigImage()
                }
                return cell
            } else {
                let model : CrtGetinfoModel_items = self.itemsArr[indexPath.row]
                if model.type! == 0 {
                    let cell : TitleTableViewCell  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                    cell.setData_crtinfo(title: model.remark!, content: model.value!, indexPath: indexPath)
                    model.tagNum = indexPath.row
                    cell.delegate = self
                    return cell

                } else if model.type! == 1 {
                    let cell : ContentTableViewCell  = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCellID, for: indexPath) as! ContentTableViewCell
                    cell.setData_dealDetail(titleStr: model.remark!, contentStr: model.value!)
                    model.tagNum = indexPath.row
                    cell.delegate = self
                    return cell

                } else if model.type! == 2  ||  model.type! == 3 {
                    let cell : endTimeTableViewCell  = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                    cell.setData_case(titleStr: model.remark!, timeStr: model.value!)
                    model.tagNum = indexPath.row
                    return cell

                } else {
                    let cell : OptionTableViewCell  = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCellID, for: indexPath) as! OptionTableViewCell
                    var  str  = ""
                    if model.optionArr.count > 0 {
                        str = model.optionArr[0]
                    }
                    cell.setData_caseDetail(titleStr: model.remark!, contentStr: str)
                    model.tagNum = indexPath.row
                    return cell
                }
            }
        } else {
            return UITableViewCell()
        }

    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {


        if indexPath.section == 0{



        } else {
            if indexPath.row < itemsArr.count && itemsArr.count > 0 {
                let model : CrtGetinfoModel_items = itemsArr[indexPath.row]
                if model.type == 2 || model.type == 3 {
                    //时间
                    self.showTime_start(indexPath: indexPath)

                } else if model.type == 4 {
                    //选项
                    self.showOption(indexPath: indexPath)
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {


        if indexPath.section == 0 {
            return CrtGetinfoImageTableViewCellH
        } else {

            if itemsArr.count > 0 && indexPath.row < itemsArr.count {
                let model = self.itemsArr[indexPath.row]
                switch model.type {
                case 0 :
                    return TitleTableViewCellH
                case 1:
                    return ContentTableViewCellH
                case 2 :
                    return OptionTableViewCellH
                case 3 :
                    return OptionTableViewCellH
                case 4:
                    return OptionTableViewCellH
                default:
                    return OptionTableViewCellH
                }

            } else {
                return 0
            }
        }
    }


    func showOption(indexPath : IndexPath) {
        self.maskView.addSubview(self.optionView)
        self.view.window?.addSubview(self.maskView)

        var model : CrtGetinfoModel_items!
        for submModel in itemsArr {
            if submModel.tagNum == indexPath.row {
                model = submModel
            }
        }

        self.optionView.setData_crt(tagNum: indexPath.row, dataArr: model.optionArr)
        self.optionView.delegate = self
        self.optionView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(160)
        }
    }


    func endEdite(inputStr: String, tagNum: Int) {
        for submModel in itemsArr {
            if submModel.tagNum == tagNum {
                submModel.value = inputStr
            }
        }
    }

    func endText_content(content: String, tagNum: Int) {
        for submModel in itemsArr {
            if submModel.tagNum == tagNum {
                submModel.value = content
            }
        }
    }

    func optionSure(idStr: String, titleStr: String,noteStr : String, pickTag: Int) {
        for submModel in itemsArr {
            if submModel.tagNum == pickTag {
                submModel.value = titleStr
            }
        }

        let cell : OptionTableViewCell = self.mainTabelView.cellForRow(at: [0,pickTag]) as! OptionTableViewCell
        cell.setOptionData(contentStr: titleStr)

        self.timeView.removeFromSuperview()
        self.maskView.removeFromSuperview()
    }


    func showBigImage() {

        self.iconImageView.setImage_kf(imageName: dataModel.deals.docimg!, placeholderImage: #imageLiteral(resourceName: "log_bag"))
        self.maskView.addSubview(self.iconImageView)
        self.maskView.isUserInteractionEnabled = true
        self.view.window?.addSubview(self.maskView)

        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(disMissImage))
        self.maskView.addGestureRecognizer(tap)

    }

    @objc func disMissImage() {

        self.iconImageView.removeFromSuperview()
        self.maskView.removeFromSuperview()

    }

    func datePickViewTime(timeStr: String, type: Int) {
        for submModel in itemsArr {
            if submModel.tagNum == type {
                submModel.value = timeStr
            }
        }

        let cell : endTimeTableViewCell = self.mainTabelView.cellForRow(at: [0,type]) as! endTimeTableViewCell
        cell.setTime(str: timeStr)

        self.timeView.removeFromSuperview()
        self.maskView.removeFromSuperview()


        
    }

    func showTime_start(indexPath: IndexPath) {
        self.view.endEditing(true)
        timeView.removeFromSuperview()
        self.maskView.addSubview(self.timeView)
        self.view.window?.addSubview(self.maskView)

        timeView.setData(type: indexPath.row)
        timeView.delegate = self

        timeView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(160)
        }
    }




    // MARK: - net
    func requestApi() {
        requestVC.delegate = self
        requestVC.crt_getinfoReqeust(id: docID!, f: id!)
    }



    func requestSucceed_work2(data: Any, type: Work2RequestVC_enum) {
        if type == .crt_getinfo {
            dataModel  = data as! CrtGetinfoModel
            itemsArr = dataModel.items
            self.mainTabelView.reloadData()
        } else {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }

    func requestFail_work2() {

    }


    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }

    override func navigationRightBtnClick() {
        HCLog(message: "确定")
        self.view.endEditing(true)
        requestVC.crt_saveRequest(id: self.id, dataArr: self.dataModel.items)
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
