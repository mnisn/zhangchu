//
//  MainTabBarViewController.swift
//  zhangchu
//
//  Created by 苏宁 on 2016/10/21.
//  Copyright © 2016年 suning. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    //tabbar背景
    private var tabBarBgView:UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        //创建视图控制器
        createViewControllers()
        //自定制tabbar
        createTabBar()
    }
    
    //自定制tabbar
    func createTabBar()
    {
        tabBar.hidden = true
        
        //
        tabBarBgView = UIView.createView()
        view.addSubview(tabBarBgView)
        //
        tabBarBgView.backgroundColor = UIColor(white: 0.9, alpha: 1)
//        tabBarBgView.layer.borderColor = UIColor.blackColor().CGColor
//        tabBarBgView.layer.borderWidth = 0.5
        //
        tabBarBgView.snp_makeConstraints {
            [weak self](make) in
            make.left.right.bottom.equalTo(self!.view)
            make.height.equalTo(49)
        }
        
        let nameArray = ["zhangchu.RecipeViewController","zhangchu.CommunityViewController","zhangchu.HappyLifeViewController","zhangchu.MyViewController"]
        //
        let iconTitle = ["食谱","乐活","社区","我的"]
        //
        let iconNameNormal = ["home_normal","shike_normal","community_normal","mine_normal"]
        //
        let iconNameSelect = ["home_select","shike_select","community_select","mine_select"]
        //
        let width = screenWidth / CGFloat(nameArray.count)
        
        for i in 0 ..< nameArray.count
        {
            //
            let btn = UIButton.createButton(nil, bgImgName: iconNameNormal[i], highlightImgName: nil, selectImgName: iconNameSelect[i], target: self, action: #selector(btnClick(_:)))
            tabBarBgView.addSubview(btn)
            btn.tag = 300 + i
            //设置位置
            btn.snp_makeConstraints(closure: {
                [weak self](make) in
                make.top.bottom.equalTo((self?.tabBarBgView)!)
                make.width.equalTo(width)
                make.left.equalTo(width * CGFloat(i))
            })
            
            //标题
            let titleLabel = UILabel.createLabel(iconTitle[i], textAlignment: .Center, font: UIFont.systemFontOfSize(12))
            btn.addSubview(titleLabel)
            //设置位置
            titleLabel.snp_makeConstraints(closure: {
                (make) in
                make.bottom.left.right.equalTo(btn)
                make.height.equalTo(18)
            })
        }
    }
    
    func btnClick(btn:UIButton)
    {
        let index = btn.tag - 300
        //
        if selectedIndex != index
        {
            //取消之前选中的按钮
            let lastbtn = tabBarBgView.viewWithTag(300 + selectedIndex) as! UIButton
            lastbtn.selected = false
            lastbtn.userInteractionEnabled = true
            //
            btn.selected = true
            btn.userInteractionEnabled = false
            //
            selectedIndex = index
        }
    }
    
    //创建视图控制器
    func createViewControllers()
    {
        let nameArray = ["zhangchu.RecipeViewController","zhangchu.CommunityViewController","zhangchu.HappyLifeViewController","zhangchu.MyViewController"]
        //
        var controllerArray:[UINavigationController] = []
        
        for i in 0 ..< nameArray.count
        {
            //
            let controller = NSClassFromString(nameArray[i]) as! UIViewController.Type
            //
            let vc = controller.init()
            //
            let nav = UINavigationController(rootViewController: vc)
            //
            controllerArray.append(nav)
        }
        viewControllers = controllerArray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
