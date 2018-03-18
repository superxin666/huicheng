//
//  PubMessageConViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/18.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit

class PubMessageConViewController: BaseViewController {
    var contentView : PubMesConView!
    
    override func viewWillLayoutSubviews() {
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(LNAVIGATION_HEIGHT + 10)
            make.left.equalTo(self.view).offset(10)
            make.right.equalTo(self.view).offset(-10)
            make.bottom.equalTo(self.view).offset(-160)
  
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = viewBackColor
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        self.navigation_title_fontsize(name: "公告", fontsize: 18)
        contentView = PubMesConView.loadNib()
        self.view.addSubview(contentView)
        
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
