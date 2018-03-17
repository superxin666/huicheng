//
//  AppDelegate.swift
//  huicheng
//
//  Created by lvxin on 2018/2/22.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UITabBarControllerDelegate {

    var window: UIWindow?
    var tab : UITabBarController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.showMain()
//        self.showLogin()
        return true
    }
    
    
    func showLogin()  {
        let vc = LogInViewController()
        self.window?.rootViewController = vc
    }
    
    /// tab
    func showMain()  {
        //消息
        let mesVc :MessageViewController = MessageViewController()
        let mesNv :UINavigationController = HCNavigationController(rootViewController: mesVc)
        let item1:UITabBarItem = UITabBarItem(title:"消息", image:#imageLiteral(resourceName: "mes_tab_nor").withRenderingMode(UIImageRenderingMode.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "mes_tab_sel").withRenderingMode(UIImageRenderingMode.alwaysOriginal))
        mesNv.tabBarItem = item1
        
        //工作
        let workVc :WorkViewController = WorkViewController()
        let workNv :UINavigationController = HCNavigationController(rootViewController: workVc)
        let item2:UITabBarItem = UITabBarItem(title:"工作", image:#imageLiteral(resourceName: "work_tab_nor").withRenderingMode(UIImageRenderingMode.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "work_tab_sel").withRenderingMode(UIImageRenderingMode.alwaysOriginal))
        workNv.tabBarItem = item2
        
        //便捷
        let convenVc :ConvenViewController = ConvenViewController()
        let convenNv :UINavigationController = HCNavigationController(rootViewController: convenVc)
        let item3:UITabBarItem = UITabBarItem(title:"便捷", image:#imageLiteral(resourceName: "con_tab_nor").withRenderingMode(UIImageRenderingMode.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "con_tab_sel").withRenderingMode(UIImageRenderingMode.alwaysOriginal))
        convenNv.tabBarItem = item3
        
        //我的
        let minVc :MineViewController = MineViewController()
        let minNv :UINavigationController = HCNavigationController(rootViewController: minVc)
        let item4:UITabBarItem = UITabBarItem(title:"我的", image:#imageLiteral(resourceName: "mine_tab_nor").withRenderingMode(UIImageRenderingMode.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "mine_tab_sel").withRenderingMode(UIImageRenderingMode.alwaysOriginal))
        minNv.tabBarItem = item4
        
        
        
        let vcArr = [mesNv,workNv,convenNv,minNv]
        tab = UITabBarController()
//        tab.tabBar.barTintColor = blue_COLOUR
        tab.delegate = self
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.hc_colorFromRGB(rgbValue: 0x5B6679)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.hc_colorFromRGB(rgbValue: 0xff6900)], for: .selected)
        tab.viewControllers = vcArr
        self.window?.rootViewController = tab
    }

}

