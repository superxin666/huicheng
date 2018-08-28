//
//  BaseViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/5.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import MJRefresh

class BaseViewController: UIViewController {

    let header = MJRefreshNormalHeader() //头部刷新
    let footer = MJRefreshAutoNormalFooter() // 底部刷新

    /// 背景
    lazy var maskView : UIView   = {()-> UIView in
        let view = UIView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: KSCREEN_HEIGHT))
        view.backgroundColor = UIColor.hc_ColorFromInt(red: 0, green: 0, blue: 0, alpha: 0.7)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    // MARK: UI
    func navigation_title_fontsize(name:String, fontsize:Int, textColour:UIColor = darkblueColor) {
        self.title = name
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: ip6(fontsize))]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: textColour]
    }
    
    /// 导航栏 左键 文字类型
    ///
    /// - Parameters:
    ///   - name: 标题
    ///   - textColour: 标题颜色
    func navigationBar_leftBtn_title(name:String, textColour:UIColor = .black){
        let btn:UIButton = UIButton(type: UIButtonType.custom)
        btn.frame = CGRect(x: 0, y: 0, width: 60, height: 44)
        btn.setTitle(name, for: .normal)
        btn.setTitleColor(textColour, for: .normal)
        btn.addTarget(self, action:#selector(BaseViewController.navigationLeftBtnClick), for: .touchUpInside)
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        let item:UIBarButtonItem = UIBarButtonItem(customView:btn)
        self.navigationItem.leftBarButtonItem = item
    }
    
    
    /// 导航栏 左键 图片类型
    ///
    /// - Parameter image: 图片
    func navigationBar_leftBtn_image(image:UIImage){
        let btn:UIButton = UIButton(type: UIButtonType.custom)
        btn.frame = CGRect(x: 0, y: 0, width: 60, height: 44)
        btn.setImage(image, for:.normal)
//        btn.backgroundColor = .red
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0)
        btn.addTarget(self, action:#selector(BaseViewController.navigationLeftBtnClick), for: .touchUpInside)
        let item:UIBarButtonItem = UIBarButtonItem(customView:btn)
        self.navigationItem.leftBarButtonItem = item
    }
    
    
    /// 导航栏 右键 文字类型
    ///
    /// - Parameters:
    ///   - name: 标题
    ///   - textColour: 标题颜色
    func navigationBar_rightBtn_title(name:String, textColour:UIColor = darkblueColor){
        let btn:UIButton = UIButton(type: UIButtonType.custom)
        btn.frame = CGRect(x: 0, y: 0, width: 60, height: 44)
        btn.setTitle(name, for: .normal)
        btn.setTitleColor(textColour, for: .normal)
        btn.addTarget(self, action:#selector(BaseViewController.navigationRightBtnClick), for: .touchUpInside)
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        let item:UIBarButtonItem = UIBarButtonItem(customView:btn)
        self.navigationItem.rightBarButtonItem = item
    }
    
    /// 导航栏 右键 图片类型
    ///
    /// - Parameter image: 图片
    func navigationBar_rightBtn_image(image:UIImage){
        let btn:UIButton = UIButton(type: UIButtonType.custom)
        btn.frame = CGRect(x: 0, y: 0, width: 60, height: 44)
        btn.setImage(image, for:.normal)
//        btn.backgroundColor = .red
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0)
        btn.addTarget(self, action:#selector(BaseViewController.navigationRightBtnClick), for: .touchUpInside)
        let item:UIBarButtonItem = UIBarButtonItem(customView:btn)
        self.navigationItem.rightBarButtonItem = item
    }
    
    /// 创建UIBarButtonItem
    ///
    /// - Parameter image: 图片
    /// - Returns: item
    func getUIBarButtonItem(image : UIImage, action : Selector, vc  :UIViewController)->UIBarButtonItem {
        
        let btn:UIButton = UIButton(type: UIButtonType.custom)
        btn.frame = CGRect(x: 0, y: 0, width: 60, height: 44)
        btn.setImage(image, for:.normal)
        btn.addTarget(vc, action: action, for: .touchUpInside)
//                btn.backgroundColor = .red
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -30)
        let item:UIBarButtonItem = UIBarButtonItem(customView:btn)
        return item
    }


    func getUIBarButtonItem_title(title : String, action : Selector, vc  :UIViewController, textColour:UIColor = darkblueColor)->UIBarButtonItem {

        let btn:UIButton = UIButton(type: UIButtonType.custom)
        btn.frame = CGRect(x: 0, y: 0, width: 60, height: 44)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(textColour, for: .normal)
        btn.addTarget(vc, action: action, for: .touchUpInside)
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -30)
        let item:UIBarButtonItem = UIBarButtonItem(customView:btn)
        return item
    }

    
    func creactFoot()->MJRefreshAutoNormalFooter {
        let footer = MJRefreshAutoNormalFooter() // 底部刷新
        footer.setTitle("", for: .idle)
        return footer
    }

    
    // MARK: response
    @objc func navigationLeftBtnClick() {
        
    }
    
    @objc func navigationRightBtnClick() {
        
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
