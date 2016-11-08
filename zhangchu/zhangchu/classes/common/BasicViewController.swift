//
//  BasicViewController.swift
//  zhangchu
//
//  Created by 苏宁 on 2016/10/21.
//  Copyright © 2016年 suning. All rights reserved.
//

import UIKit

class BasicViewController: UIViewController {
    
    func addNavBtn(imgName:String, target:AnyObject?, action:Selector, isLeft:Bool)
    {
        let btn = UIButton.createButton(nil, bgImgName: imgName, highlightImgName: nil, selectImgName: nil, target: target, action: action)
        btn.frame = CGRectMake(10, 0, 22, 33)
        let barBtn = UIBarButtonItem(customView: btn)
        if isLeft
        {
            navigationItem.leftBarButtonItem = barBtn
        }
        else
        {
            navigationItem.rightBarButtonItem = barBtn
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.whiteColor()
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
