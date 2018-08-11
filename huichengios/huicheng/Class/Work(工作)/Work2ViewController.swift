//
//  Work2ViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/8/11.
//  Copyright © 2018年 lvxin. All rights reserved.
//  工作 平台

import UIKit
let iteamW :CGFloat = ip6(80)
let iteamH :CGFloat = ip6(60)
let Work2ViewController_id = "Work2ViewController_id"
class Work2ViewController: BaseViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    var colletionView : UICollectionView!
    let userDataModel = UserDataSingle.sharedInstance.dataModel


    override func viewWillLayoutSubviews() {
        colletionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(0)
            make.left.right.equalTo(self.view).offset(0)
            make.bottom.equalTo(self.view).offset(0)
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = viewBackColor
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "mes_logo"))
        self.navigation_title_fontsize(name: "工作", fontsize: 18)

        HCLog(message: "数据模型")
        HCLog(message: userDataModel?.power.count)
        self.creatUI()
        

    }

    func creatUI() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: iteamW, height: iteamH)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 1.5
        layout.minimumLineSpacing = 1.5

        colletionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        colletionView.register(WorkCollectionViewCell.self, forCellWithReuseIdentifier: Work2ViewController_id)
        colletionView.backgroundColor = .clear
        colletionView.delegate = self
        colletionView.dataSource = self
        colletionView.showsVerticalScrollIndicator = false
        colletionView.showsHorizontalScrollIndicator = false
        self.view.addSubview(colletionView)

        
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (userDataModel?.power.count)!
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let model : LoginModel_power = (userDataModel?.power[section])!
        return model.childrens.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell :WorkCollectionViewCell  = collectionView.dequeueReusableCell(withReuseIdentifier: Work2ViewController_id, for: indexPath) as! WorkCollectionViewCell

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

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
