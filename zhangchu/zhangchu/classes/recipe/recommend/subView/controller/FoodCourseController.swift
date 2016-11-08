//
//  FoodCourseController.swift
//  zhangchu
//
//  Created by 苏宁 on 2016/11/3.
//  Copyright © 2016年 suning. All rights reserved.
//

import UIKit

class FoodCourseController: BasicViewController {

    var courseId:String?
    
    //选择了第几集
    private var selectIndex = 0
    
    var tableView:UITableView?
    
    //
    private var detailData:FoodCourseDetailModel?
    //
    private var comentData:FoodCourseCommentModel?
    
    private var curPage = 1
    private var hasMore:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadDetailData()
        downloadCommentData()
        createTableView()
    }
    
    func downloadDetailData()
    {
        //methodName=CourseSeriesView&series_id=22&token=&user_id=&version=4.32
        if courseId != nil
        {
            let params = ["methodName":"CourseSeriesView","series_id":"\(courseId!)"]
            let download = ZCDownload()
            download.delegate = self
            download.postWithUrl(kHostUrl, params: params)
            download.downloadType = .FoodCourseDetail
        }
    }
    
    func downloadCommentData()
    {
        //methodName=CommentList&page=1&relate_id=22&size=10&token=&type=2&user_id=&version=4.32
        if courseId != nil
        {
            let params = ["methodName":"CommentList","page":"\(curPage)","relate_id":"\(courseId!)","size":"10","type":"2"]
            let download = ZCDownload()
            download.delegate = self
            download.postWithUrl(kHostUrl, params: params)
            download.downloadType = .FoodCourseComment
        }
    }
    
    func createTableView()
    {
        automaticallyAdjustsScrollViewInsets = false
        
        tableView = UITableView(frame: CGRectZero, style: .Plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        view.addSubview(tableView!)
        
        tableView?.snp_makeConstraints(closure: {
            (make) in
            make.top.equalTo(view).offset(64)
            make.left.right.bottom.equalTo(view)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension FoodCourseController:ZCDownloadDelegate
{
    func download(download: ZCDownload, didFailWithError error: NSError)
    {
        print(error)
    }
    func download(download: ZCDownload, didFinishWithData data: NSData?)
    {
        if download.downloadType == .FoodCourseDetail
        {
//            let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
//            print(str!)
            if let tmpData = data
            {
                detailData = FoodCourseDetailModel.parseData(tmpData)
                //
                tableView?.reloadData()
            }
        }
        else if download.downloadType == .FoodCourseComment
        {
            //            let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
            //            print(str!)
            if let tmpData = data
            {
                if curPage == 1
                {
                    comentData = FoodCourseCommentModel.parseData(tmpData)
                }
                else
                {
                    let array = NSMutableArray(array: (comentData?.data?.data)!)
                    array.addObjectsFromArray((FoodCourseCommentModel.parseData(tmpData).data?.data)!)
                    comentData?.data?.data? = NSArray(array: array) as! [FoodCourseCommentDataData]
                }
                tableView?.reloadData()
                
                //
                if comentData?.data?.data?.count < NSString(string: (comentData?.data?.total)!).integerValue
                {
                    hasMore = true
                }
                else
                {
                    hasMore = false
                }
                
                addFooterView()
            }
        }
    }
    
    //加载更多
    func addFooterView()
    {
        let fview = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        fview.backgroundColor = UIColor.lightGrayColor()
        
        let label = UILabel(frame: CGRect(x: 20, y: 10, width: screenWidth - 40, height: 24))
        label.textAlignment = .Center
        if hasMore
        {
            label.text = "下拉加载更多"
        }
        else
        {
            label.text = "没有更多数据"
        }
        fview.addSubview(label)
        
        tableView?.tableFooterView = fview
    }
}

extension FoodCourseController:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var num = 0
        if section == 0
        {
            if detailData != nil
            {
                num = 3
            }
        }
        else if section == 1
        {
            if comentData?.data?.data?.count > 0
            {
                num = (comentData?.data?.data?.count)!
            }
        }
        return num
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var height:CGFloat = 0
        if indexPath.section == 0
        {
            if indexPath.row == 0
            {
                height = 160
            }
            else if indexPath.row == 1
            {
                let model = detailData?.data?.data![selectIndex]
                height = FoodCourseDescCell.heightForDescCell(model!)
            }
            else if indexPath.row == 2
            {
                height = FoodCourseNumCell.heightForNumCell((detailData?.data!.data!.count)!)
            }
            
        }
        else if indexPath.section == 1
        {
            height = 80
        }
        return height
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0
        {
            if indexPath.row == 0
            {
                var cell = tableView.dequeueReusableCellWithIdentifier("foodCourseVideoCell") as? FoodCourseVideoCell
                if cell == nil
                {
                    cell = NSBundle.mainBundle().loadNibNamed("FoodCourseVideoCell", owner: nil, options: nil).last as? FoodCourseVideoCell
                }
                let model = detailData?.data?.data![selectIndex]
                cell?.cellModel = model
                
                //
                cell?.playClosure = {
                    [weak self]url in
                    RecipeService.handelEvents(url, onViewController: self!)
                }
                
                cell?.selectionStyle = .None
                return cell!
            }
            
            else if indexPath.row == 1
            {
                var cell = tableView.dequeueReusableCellWithIdentifier("foodCourseDescCell") as? FoodCourseDescCell
                if cell == nil
                {
                    cell = NSBundle.mainBundle().loadNibNamed("FoodCourseDescCell", owner: nil, options: nil).last as? FoodCourseDescCell
                }
                let model = detailData?.data?.data![selectIndex]
                cell?.cellModel = model
                
                cell?.separatorInset = UIEdgeInsetsMake(0, screenWidth, 0, 0)
                cell?.selectionStyle = .None
                return cell!
            }
            else if indexPath.row == 2
            {
                var cell = tableView.dequeueReusableCellWithIdentifier("foodCourseNumCell") as? FoodCourseNumCell
                if cell == nil
                {
                    cell = FoodCourseNumCell(style: .Default, reuseIdentifier: "foodCourseNumCell")
                }
                cell?.courseNum = detailData?.data?.data?.count
                //
                cell?.selectIndex = selectIndex
                
                cell?.clickClosure = {
                    [weak self] index in
                    self!.selectIndex = index
                    //
                    self!.tableView?.reloadSections(NSIndexSet(index: 0), withRowAnimation: .None)
                }
                
                cell?.selectionStyle = .None
                return cell!
            }
        }
        else if indexPath.section == 1
        {
            var cell = tableView.dequeueReusableCellWithIdentifier("foodCourseCommentCell") as? FoodCourseCommentCell
            if cell == nil
            {
                cell = NSBundle.mainBundle().loadNibNamed("FoodCourseCommentCell", owner: nil, options: nil).last as? FoodCourseCommentCell
            }
            let model = comentData?.data?.data![indexPath.row]
            cell?.model = model
            
            cell?.selectionStyle = .None
            return cell!
        }
        return UITableViewCell()
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.bounds.height - 10
        {
            //
            if hasMore
            {
                curPage += 1
                downloadCommentData()
            }
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1
        {
            if comentData?.data?.data?.count > 0
            {
                return 60
            }
        }
        return 0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = NSBundle.mainBundle().loadNibNamed("FoodCourseCommentHeader", owner: nil, options: nil).last as! FoodCourseCommentHeader
        
        headerView.config((comentData?.data?.total)!)
        
        return headerView
    }
}











