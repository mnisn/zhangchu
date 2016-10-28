//
//  RecommendTodayCell.swift
//  zhangchu
//
//  Created by 苏宁 on 2016/10/27.
//  Copyright © 2016年 suning. All rights reserved.
//

import UIKit

class RecommendTodayCell: UITableViewCell {
    
    var clickClosure:RecipClickClosure?
    
    var listModle:RecipeRecommendWidgetList? {
        didSet{
            showData()
        }
    }
    
    func showData()
    {
        if listModle?.widget_data?.count > 0
        {
            for i in 0 ..< 3
            {
                //图片
                if i * 4 < listModle?.widget_data?.count
                {
                    let imgData = listModle?.widget_data![i * 4]
                    if imgData?.type == "image"
                    {
                        let tmpView = contentView.viewWithTag(100 + i)
                        if tmpView?.isKindOfClass(UIImageView) == true
                        {
                            let imgView = tmpView as! UIImageView
                            imgView.kf_setImageWithURL(NSURL(string: (imgData?.content)!), placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                        }
                    }
                }
                //标题
                if i * 4 + 2 < listModle?.widget_data?.count
                {
                    let textTitleData = listModle?.widget_data![i * 4 + 2]
                    if textTitleData!.type == "text"
                    {
                        let tmpView = contentView.viewWithTag(200 + i)
                        if tmpView?.isKindOfClass(UILabel) == true
                        {
                            let textTitleLabel = tmpView as! UILabel
                            textTitleLabel.text = textTitleData?.content
                        }
                    }
                }
                //内容
                if i * 4 + 3 < listModle?.widget_data?.count
                {
                    let textConData = listModle?.widget_data![i * 4 + 3]
                    if textConData!.type == "text"
                    {
                        let tmpView = contentView.viewWithTag(300 + i)
                        if tmpView?.isKindOfClass(UILabel) == true
                        {
                            let textConLabel = tmpView as! UILabel
                            textConLabel.text = textConData?.content
                        }
                    }
                }
            }
        }
    }
    
    //点击进入详情
    @IBAction func btnClick(sender: UIButton)
    {
        let index = sender.tag - 400
        if index * 4 < listModle?.widget_data?.count
        {
            let imgData = listModle?.widget_data![index * 4]
            if imgData?.type == "image"
            {
                if clickClosure != nil && imgData?.link != nil
                {
                    clickClosure!((imgData?.link)!)
                }
            }
        }
    }
    
    //点击播放视频
    @IBAction func playBtnClick(sender: UIButton)
    {
        let index = sender.tag - 500
        if index * 4 + 1 < listModle?.widget_data?.count
        {
            let videoData = listModle?.widget_data![index * 4 + 1]
            if videoData?.type == "video"
            {
                if clickClosure != nil && videoData?.content != nil
                {
                    clickClosure!((videoData?.content)!)
                }
            }
        
        }
    }
    
    //创建cell
    class func createTodayCell(tableView: UITableView, atIndexPath indexPath:NSIndexPath, listModel:RecipeRecommendWidgetList?) ->RecommendTodayCell
    {
        let cellID = "recommendTodayCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellID) as? RecommendTodayCell
        if cell == nil
        {
            cell = NSBundle.mainBundle().loadNibNamed("RecommendTodayCell", owner: nil, options: nil).last as? RecommendTodayCell
        }
        cell?.listModle = listModel!
        return cell!
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
