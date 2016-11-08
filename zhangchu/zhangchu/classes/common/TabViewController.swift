//
//  TabViewController.swift
//  zhangchu
//
//  Created by 苏宁 on 2016/11/4.
//  Copyright © 2016年 suning. All rights reserved.
//

import UIKit

class TabViewController: BasicViewController {
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        //
        let mainCtrl = ((UIApplication.sharedApplication().delegate) as! AppDelegate).window?.rootViewController as! MainTabBarViewController
        mainCtrl.hideTabber()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //
        let mainCtrl = ((UIApplication.sharedApplication().delegate) as! AppDelegate).window?.rootViewController as! MainTabBarViewController
        mainCtrl.showTabbar()
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
