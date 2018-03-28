//
//  SetViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/28.
//  Copyright © 2018年 lvxin. All rights reserved.
//  设置页面

import UIKit

class SetViewController: BaseViewController,SetBackViewDelegate {
    var backView : SetBackView!
    

    override func viewWillLayoutSubviews() {
        backView.snp.makeConstraints { (make) in
            make.top.equalTo(LNAVIGATION_HEIGHT)
            make.left.right.equalTo(0)
            make.height.equalTo(150)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = viewBackColor
        self.navigation_title_fontsize(name: "设置", fontsize: 18)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
//        backView = SetBackView.loadNib()
        
        backView = SetBackView.loadNib()
        backView.delegate = self
        self.view.addSubview(backView)

    }
    
    func resetKeyDelegate() {
        let vc = ResetKeyViewControllerViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func logoutDelegate() {
        //
        UserInfoLoaclManger.cleanKey()
        let dele :AppDelegate = UIApplication.shared.delegate as! AppDelegate
        dele.showLogin()
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
