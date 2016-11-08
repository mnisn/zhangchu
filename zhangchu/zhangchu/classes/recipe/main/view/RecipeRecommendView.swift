//
//  RecipeRecommendView.swift
//  zhangchu
//
//  Created by 苏宁 on 2016/10/25.
//  Copyright © 2016年 suning. All rights reserved.
//

import UIKit

//食谱-推荐-widget列表
public enum RecommendWidgetType: Int
{
    case WidgetBtn = 1//新手入门等
    case WidgetImg = 2//
    case WidgetToday = 5//今日新品
    case WidgetOther = 3
    case WidgetList = 9
    case WidgetTalent = 4
    case WidgetChosen = 8
    case WidgetTopic = 7
}

class RecipeRecommendView: UIView {
    
    var clickClosure:RecipClickClosure?

    //数据
    var model:RecipeRecommendModel?{
        didSet{
            //set方法调用之后会调用这里的方法
            tableView?.reloadData()
        }
    }
    //表格
    private var tableView:UITableView?
    //重新实现初始化方法
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        //创建表格视图
        tableView = UITableView(frame: CGRectZero, style: .Plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        self.addSubview(tableView!)
        
        tableView?.snp_makeConstraints(closure: {
            [weak self](make) in
            make.edges.equalTo(self!)
        })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

extension RecipeRecommendView:UITableViewDataSource,UITableViewDelegate
{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var section = 1
        if model?.data?.widgetList?.count > 0
        {
            section += (model?.data?.widgetList?.count)!
        }
        return section
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var row = 0
        if section == 0
        {
            row = 1
        }
        else
        {
            //
            let listModel = model?.data?.widgetList![section - 1]
            if (listModel?.widget_type?.integerValue)! == RecommendWidgetType.WidgetBtn.rawValue ||
                (listModel?.widget_type?.integerValue)! == RecommendWidgetType.WidgetImg.rawValue ||
                (listModel?.widget_type?.integerValue)! == RecommendWidgetType.WidgetToday.rawValue ||
                (listModel?.widget_type?.integerValue)! == RecommendWidgetType.WidgetOther.rawValue ||
                (listModel?.widget_type?.integerValue)! == RecommendWidgetType.WidgetList.rawValue ||
                (listModel?.widget_type?.integerValue)! == RecommendWidgetType.WidgetChosen.rawValue
            {
                //
                row = 1
            }
            else if (listModel?.widget_type?.integerValue)! == RecommendWidgetType.WidgetTalent.rawValue
            {
                row = (listModel?.widget_data?.count)! / 4
            }
            else if (listModel?.widget_type?.integerValue)! == RecommendWidgetType.WidgetTopic.rawValue
            {
                row = (listModel?.widget_data?.count)! / 3
            }

        }
        return row
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height:CGFloat = 0
        if indexPath.section == 0
        {
            height = 140
        }
        else
        {
            let listModel = model?.data?.widgetList![indexPath.section - 1]
            if (listModel?.widget_type?.integerValue)! == RecommendWidgetType.WidgetBtn.rawValue
            {
                height = 70
            }
            else if (listModel?.widget_type?.integerValue)! == RecommendWidgetType.WidgetImg.rawValue
            {
                height = 75
            }
            else if (listModel?.widget_type?.integerValue)! == RecommendWidgetType.WidgetToday.rawValue
            {
                height = 160
            }
            else if (listModel?.widget_type?.integerValue)! == RecommendWidgetType.WidgetOther.rawValue
            {
                height = 200
            }
            else if (listModel?.widget_type?.integerValue)! == RecommendWidgetType.WidgetList.rawValue
            {
                height = 60
            }
            else if (listModel?.widget_type?.integerValue)! == RecommendWidgetType.WidgetTalent.rawValue
            {
                height = 100
            }
            else if (listModel?.widget_type?.integerValue)! == RecommendWidgetType.WidgetChosen.rawValue
            {
                height = 170
            }
            else if (listModel?.widget_type?.integerValue)! == RecommendWidgetType.WidgetTopic.rawValue
            {
                height = 140
            }
        }
        
        return height
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0
        {
            let cell = RecommendBannerCell.createBannerCell(tableView, atIndexPath: indexPath, bannerArray: model?.data!.bannerArray)
            
            cell.clickClosure = clickClosure
            
            return cell
        }
        else
        {
            let listModel = model?.data?.widgetList![indexPath.section - 1]
            if (listModel?.widget_type?.integerValue)! == RecommendWidgetType.WidgetBtn.rawValue
            {
                let cell = RecommendWidgetBtnCell.createWidgetBtnCell(tableView, atIndexPath: indexPath, listModel: listModel)
                //
                cell.clickClosure = clickClosure
                return cell
            }
            else if (listModel?.widget_type?.integerValue)! == RecommendWidgetType.WidgetImg.rawValue
            {
                let cell = RecommendWidgetImgCell.createWidgetImgCell(tableView, atIndexPath: indexPath, listModel: listModel)
                //
                cell.clickClosure = clickClosure
                return cell
            }
            else if (listModel?.widget_type?.integerValue)! == RecommendWidgetType.WidgetToday.rawValue
            {
                let cell = RecommendTodayCell.createTodayCell(tableView, atIndexPath: indexPath, listModel: listModel)
                //
                cell.clickClosure = clickClosure
                return cell
            }
            else if (listModel?.widget_type?.integerValue)! == RecommendWidgetType.WidgetOther.rawValue
            {
                let cell = RecommendOtherFoodCell.createOtherCell(tableView, atIndexPath: indexPath, listModel: listModel)
                //
                cell.clickClosure = clickClosure
                return cell
            }
            else if (listModel?.widget_type?.integerValue)! == RecommendWidgetType.WidgetList.rawValue
            {
                let cell = RecommendListCell.createListCell(tableView, atIndexPath: indexPath, listModel: listModel)
                //
                cell.clickClosure = clickClosure
                return cell
            }
            else if (listModel?.widget_type?.integerValue)! == RecommendWidgetType.WidgetTalent.rawValue
            {
                let array = NSArray(array: (listModel?.widget_data)!).subarrayWithRange(NSMakeRange(indexPath.row * 4, 4)) as! [RecipeRecommendWidgetData]
                
                let cell = RecommentTalentCell.createTalentCell(tableView, atIndexPath: indexPath, cellArray: array)
                //
                cell.clickClosure = clickClosure
            
                return cell
            }
            else if (listModel?.widget_type?.integerValue)! == RecommendWidgetType.WidgetChosen.rawValue
            {
                let cell = RecommentChosenCell.createChonsenCell(tableView, atIndexPath: indexPath, listModel: listModel)
                //
                cell.clickClosure = clickClosure
                cell.selectionStyle = .None
                return cell
            }
            else if (listModel?.widget_type?.integerValue)! == RecommendWidgetType.WidgetTopic.rawValue
            {
                let array = NSArray(array: (listModel?.widget_data)!).subarrayWithRange(NSMakeRange(indexPath.row * 3, 3)) as! [RecipeRecommendWidgetData]
                
                let cell = RecommentTopicCell.createTopicCell(tableView, atIndexPath: indexPath, cellArray: array)
                //
                cell.clickClosure = clickClosure
                return cell
            }
            
        }
        
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section > 0
        {
            let listModel = model?.data?.widgetList![section - 1]
            if listModel?.widget_type?.integerValue == RecommendWidgetType.WidgetBtn.rawValue
            {
                let widgetBtnHeaderView = RecommendWidgetBtnHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 44))
                return widgetBtnHeaderView
            }
            else if listModel?.widget_type?.integerValue == RecommendWidgetType.WidgetToday.rawValue ||
                listModel?.widget_type?.integerValue == RecommendWidgetType.WidgetOther.rawValue ||
                listModel?.widget_type?.integerValue == RecommendWidgetType.WidgetTalent.rawValue ||
                listModel?.widget_type?.integerValue == RecommendWidgetType.WidgetChosen.rawValue ||
                listModel?.widget_type?.integerValue == RecommendWidgetType.WidgetTopic.rawValue
            {
                let headerView = RecommendHeaderView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 54))
                headerView.clickClosure = clickClosure
                headerView.listModel = listModel
                
                return headerView
            }
        }
        return UIView()
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section > 0
        {
            let listModel = model?.data?.widgetList![section - 1]
            if listModel?.widget_type?.integerValue == RecommendWidgetType.WidgetBtn.rawValue
            {
                return 44
            }
            else if listModel?.widget_type?.integerValue == RecommendWidgetType.WidgetToday.rawValue ||
                listModel?.widget_type?.integerValue == RecommendWidgetType.WidgetOther.rawValue ||
                listModel?.widget_type?.integerValue == RecommendWidgetType.WidgetTalent.rawValue ||
                listModel?.widget_type?.integerValue == RecommendWidgetType.WidgetChosen.rawValue ||
                listModel?.widget_type?.integerValue == RecommendWidgetType.WidgetTopic.rawValue
            {
                return 54
            }
        }
        return 0
    }
    
    //去除tableview的粘滞性
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let height:CGFloat = 54
        if scrollView.contentOffset.y >= height
        {
            scrollView.contentInset = UIEdgeInsetsMake(-height, 0, 0, 0)
        }
        else if scrollView.contentOffset.y > 0
        {
            scrollView.contentInset = UIEdgeInsetsMake(scrollView.contentOffset.y, 0, 0, 0)
        }
    }
}






