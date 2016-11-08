//
//  RecipeViewController.swift
//  zhangchu
//
//  Created by 苏宁 on 2016/10/21.
//  Copyright © 2016年 suning. All rights reserved.
//

import UIKit

class RecipeViewController: TabViewController {
    
    //滚动视图
    private var scrollView: UIScrollView?
    
    //推荐视图
    private var recommendView:RecipeRecommendView?
    //
    private var ingredientsView:RecipIngredientsView?
    //
    private var classifyView:RecipIngredientsView?
    
    //
    private var segView:RecipeSegView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        automaticallyAdjustsScrollViewInsets = false
        createNav()
        createSCView()
        downloadRecommendData()
        downloadIngredientsData()
        downloadClassifyViewData()
        
    }
    
    func createSCView()
    {
        scrollView = UIScrollView()
        scrollView!.pagingEnabled = true
        view.addSubview(scrollView!)
        scrollView?.showsHorizontalScrollIndicator = false
        
        //
        scrollView?.delegate = self
        
        //约束
        scrollView!.snp_makeConstraints {
            (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(64, 0, 49, 0))
        }
        
        //容器视图
        let containerView = UIView.createView()
        scrollView!.addSubview(containerView)
        containerView.snp_makeConstraints {
            (make) in
            make.edges.equalTo(scrollView!)
            make.height.equalTo(scrollView!)
        }
        
        //添加子视图
        //1.推荐视图
        recommendView = RecipeRecommendView()
        containerView.addSubview(recommendView!)
        
        recommendView?.snp_makeConstraints(closure: {
            (make) in
            make.top.bottom.left.equalTo(containerView)
            make.width.equalTo(screenWidth)
        })
        
        //2.食材视图
        ingredientsView = RecipIngredientsView()
        ingredientsView?.backgroundColor = UIColor.blueColor()
        containerView.addSubview(ingredientsView!)
        
        ingredientsView?.snp_makeConstraints(closure: {
            (make) in
            make.top.bottom.equalTo(containerView)
            make.width.equalTo(screenWidth)
            make.left.equalTo((recommendView?.snp_right)!)
        })
        
        //3.分类视图
        classifyView = RecipIngredientsView()
        classifyView?.backgroundColor = UIColor.redColor()
        containerView.addSubview(classifyView!)
        
        classifyView?.snp_makeConstraints(closure: {
            (make) in
            make.top.bottom.equalTo(containerView)
            make.width.equalTo(screenWidth)
            make.left.equalTo((ingredientsView?.snp_right)!)
        })
        
        //修改容器视图的大小
        containerView.snp_makeConstraints { (make) in
            make.right.equalTo(classifyView!)
        }

    
    }
    
    func createNav()
    {
        addNavBtn("saoyisao", target: self, action: #selector(btnLClick), isLeft: true)
        
        let frame = CGRectMake(80, 0, screenWidth - 80 * 2, 44)
        segView = RecipeSegView(frame: frame, titleArray: ["推荐","食材","分类"])
        navigationItem.titleView = segView
        
        segView!.delegate = self
        
    }
    
    //下载首页-推荐数据
    func downloadRecommendData()
    {
        //methodName=SceneHome
        let params = ["methodName":"SceneHome"]
        let download = ZCDownload()
        download.delegate = self
        download.postWithUrl(kHostUrl, params: params)
        download.downloadType = .Recommend
    }
    
    func btnLClick()
    {
        print("1111")
    }

    func downloadIngredientsData()
    {
        //methodName=MaterialSubtype
        let params = ["methodName":"MaterialSubtype"]
        let download = ZCDownload()
        download.delegate = self
        download.postWithUrl(kHostUrl, params: params)
        download.downloadType = .Ingredients
    }
    
    func downloadClassifyViewData()
    {
        let params = ["methodName":"CategoryIndex"]
        let download = ZCDownload()
        download.delegate = self
        download.postWithUrl(kHostUrl, params: params)
        download.downloadType = .Classify
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension RecipeViewController:ZCDownloadDelegate
{
    func download(download: ZCDownload, didFailWithError error: NSError) {
        print(error)
    }
    func download(download: ZCDownload, didFinishWithData data: NSData?) {

        if download.downloadType == .Recommend
        {
            if let tmpData = data{
                //数据
                let recommendModel = RecipeRecommendModel.parseData(tmpData)
                //UI
                recommendView!.model = recommendModel
                
                //点击食材的推荐页面的某一个部分，跳转到后面的界面
                recommendView!.clickClosure = { [weak self] clickUrl in self?.handelClickEvent(clickUrl)}
                
            }
        }
        else if download.downloadType == .Ingredients
        {
//            let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
//            print(str!)
            if let tmpData = data{
                //数据
                let ingredientsModel = RecipIngredientsModel.parseData(tmpData)
                //UI
                ingredientsView!.model = ingredientsModel

                //点击食材的推荐页面的某一个部分，跳转到后面的界面
                ingredientsView!.clickClosure = {[weak self] clickUrl in self?.handelClickEvent(clickUrl)}
                
            }
        }
        else if download.downloadType == .Classify
        {
//                    let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
//                    print(str!)
            if let tmpData = data{
                //数据
                let ingredientsModel = RecipIngredientsModel.parseData(tmpData)
                //UI
                classifyView!.model = ingredientsModel
                
                //点击食材的推荐页面的某一个部分，跳转到后面的界面
                classifyView!.clickClosure = {[weak self] clickUrl in self?.handelClickEvent(clickUrl)}
                
            }

        }
    }
    
    func handelClickEvent(url:String)
    {
//        print(url)
        RecipeService.handelEvents(url, onViewController: self)
    }
}

extension RecipeViewController:RecipeSegViewDelegate
{
    func recipeSegView(recipeSegView: RecipeSegView, didClickBtnAtIndex index: Int) {
        scrollView?.setContentOffset(CGPointMake(CGFloat(index) * screenWidth, 0), animated: true)
    }
}

extension RecipeViewController:UIScrollViewDelegate
{
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let index = scrollView.contentOffset.x / scrollView.bounds.width
        
        segView?.selectIndex = Int(index)
        
    }
}





