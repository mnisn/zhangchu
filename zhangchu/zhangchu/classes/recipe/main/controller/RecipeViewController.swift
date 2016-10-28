//
//  RecipeViewController.swift
//  zhangchu
//
//  Created by 苏宁 on 2016/10/21.
//  Copyright © 2016年 suning. All rights reserved.
//

import UIKit

class RecipeViewController: BasicViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        view.backgroundColor = UIColor.redColor()
        automaticallyAdjustsScrollViewInsets = false
        downloadRecommendData()
    }
    
    //下载首页-推荐数据
    func downloadRecommendData()
    {
        //methodName=SceneHome&token=&user_id=&version=4.5
        let params = ["methodName":"SceneHome","token":"","user_id":"","version":"4.5"]
        let download = ZCDownload()
        download.delegate = self
        download.postWithUrl(kHostUrl, params: params)
        
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

extension RecipeViewController:ZCDownloadDelegate
{
    func download(download: ZCDownload, didFailWithError error: NSError) {
        print(error)
    }
    func download(download: ZCDownload, didFinishWithData data: NSData?) {
//        let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
//        print(str!)
        if let tmpData = data{
            //数据
            let recommendModel = RecipeRecommendModel.parseData(tmpData)
            //UI
            let recommendView = RecipeRecommendView(frame: CGRectZero)
            recommendView.model = recommendModel
            view.addSubview(recommendView)
            
            //
            recommendView.clickClosure = { (str) in print(str)}
            
            //
            recommendView.snp_makeConstraints(closure: {
                [weak self](make) in
                make.edges.equalTo((self?.view)!).inset(UIEdgeInsetsMake(64, 0, 49, 0))
            })
            
        }
    }
}
