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
        
    }
    
    //自定制tabbar
    func createTabBar(iconTitle:[String], iconNameNormal:[String], iconNameSelect:[String])
    {
        tabBar.hidden = true
        
        //
        tabBarBgView = UIView.createView()
        view.addSubview(tabBarBgView)
        //
        tabBarBgView.backgroundColor = UIColor(white: 1, alpha: 1)
//        tabBarBgView.layer.borderColor = UIColor.blackColor().CGColor
//        tabBarBgView.layer.borderWidth = 0.5
        //
        tabBarBgView.snp_makeConstraints {
            [weak self](make) in
            make.left.right.bottom.equalTo(self!.view)
            make.height.equalTo(49)
        }
        
        //
        let width = screenWidth / CGFloat(iconTitle.count)
        
        for i in 0 ..< iconTitle.count
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
            titleLabel.textColor = UIColor.grayColor()
            titleLabel.tag = 400
            //设置位置
            titleLabel.snp_makeConstraints(closure: {
                (make) in
                make.bottom.left.right.equalTo(btn)
                make.height.equalTo(18)
            })
            //默认选中第一个
            if i == 0
            {
                btn.selected = true
                titleLabel.textColor = UIColor.orangeColor()
                btn.userInteractionEnabled = false
            }
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
            let lastlabel = lastbtn.viewWithTag(400) as! UILabel
            lastlabel.textColor = UIColor.grayColor()
            
            //
            btn.selected = true
            btn.userInteractionEnabled = false
            //
            let currentLabel = btn.viewWithTag(400) as! UILabel
            currentLabel.textColor = UIColor.orangeColor()
            //
            selectedIndex = index
        }
    }
    
    //创建视图控制器
    func createViewControllers()
    {
        //从文件Controllers.json中读取数据
        let path = NSBundle.mainBundle().pathForResource("Controllers", ofType: "json")
        let data = NSData(contentsOfFile: path!)
        //
        var controllerNameArray:[String] = []
        //
        var iconTitleArray:[String] = []
        var iconNameNormalArray:[String] = []
        var iconNameSelectArray:[String] = []
        //
        do
        {
            //可能出错的代码
            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
            if  json.isKindOfClass(NSArray)
            {
                let tmpArray = json as! /*Array<Dictionary<String,String>>*/[[String:String]]
                //
                for tmpDic in  tmpArray
                {
                    let name = tmpDic["controllerName"]
                    controllerNameArray.append(name!)
                    let title = tmpDic["iconTitle"]
                    iconTitleArray.append(title!)
                    let iconNormal = tmpDic["iconNameNormal"]
                    iconNameNormalArray.append(iconNormal!)
                    let iconSelect = tmpDic["iconNameSelect"]
                    iconNameSelectArray.append(iconSelect!)
                }
            }
        }
        catch (let error)
        {
            print(error)
        }
        //如果获取的数组有错误
        if iconTitleArray.count == 0
        {
            iconTitleArray = ["食谱","乐活","社区","我的"]
        }
        if iconNameNormalArray.count == 0
        {
            iconNameNormalArray = ["home_normal","shike_normal","community_normal","mine_normal"]
        }
        if iconNameSelectArray.count == 0
        {
            iconNameSelectArray = ["home_select","shike_select","community_select","mine_select"]
        }
        if controllerNameArray.count == 0
        {
            controllerNameArray = ["RecipeViewController","CommunityViewController","HappyLifeViewController","MyViewController"]
        }
        
        //
        var controllerArray:[UINavigationController] = []
        
        for i in 0 ..< controllerNameArray.count
        {
            //
            let controller = NSClassFromString("zhangchu.\(controllerNameArray[i])") as! UIViewController.Type
            //
            let vc = controller.init()
            //
            let nav = UINavigationController(rootViewController: vc)
            //
            controllerArray.append(nav)
        }
        viewControllers = controllerArray
        
        //
        //自定制tabbar
        createTabBar(iconTitleArray, iconNameNormal: iconNameNormalArray, iconNameSelect: iconNameSelectArray)
    }
    
    func showTabbar()
    {
        UIView.animateWithDuration(0.25) { 
            self.tabBarBgView.hidden = false
        }
    }

    func hideTabber()
    {
        UIView.animateWithDuration(0.25) {
            self.tabBarBgView.hidden = true
        }
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
