//
//  RecommendWidgetBtnCell.swift
//  zhangchu
//
//  Created by 苏宁 on 2016/10/25.
//  Copyright © 2016年 suning. All rights reserved.
//

import UIKit

class RecommendWidgetBtnCell: UITableViewCell {
    
    var clickClosure:RecipClickClosure?
    
    //
    var listModel:RecipeRecommendWidgetList? {
        didSet{
            showData()
        }
    }
    
    private func showData()
    {
        if listModel?.widget_data?.count > 1
        {
            for var i in 0 ..< (listModel?.widget_data?.count)! - 1
            {
                //图片 150～153
                let imgData = listModel?.widget_data![i]
                if imgData?.type == "image"
                {
                    let imgTag = 150 + i / 2
                    let imgView = contentView.viewWithTag(imgTag)
                    if imgView?.isKindOfClass(UIImageView) == true
                    {
                        let tmpImgView = imgView as! UIImageView
                        //
                        tmpImgView.kf_setImageWithURL(NSURL(string: (imgData?.content)!), placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                    }
                    
                }
                //文字
                let textData = listModel?.widget_data![i + 1]
                if textData?.type == "text"
                {
                    let label = contentView.viewWithTag(200 + i / 2)
                    if label?.isKindOfClass(UILabel) == true
                    {
                        let tmpLabel = label as! UILabel
                        tmpLabel.text = textData?.content
                    }
                }
                i += 1
            }
        }
    }
    
    //创建cell
    class func createWidgetBtnCell(tableView: UITableView, atIndexPath indexPath:NSIndexPath, listModel:RecipeRecommendWidgetList?) ->RecommendWidgetBtnCell
    {
        let cellID = "RecommendWidgetBtnCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellID) as? RecommendWidgetBtnCell
        if cell == nil
        {
            cell = NSBundle.mainBundle().loadNibNamed("RecommendWidgetBtnCell", owner: nil, options: nil).last as? RecommendWidgetBtnCell
        }
        cell?.listModel = listModel
        return cell!
    }
    
    @IBAction func btnClick(sender: UIButton)
    {
        let index = sender.tag - 100
        
        if index * 2 < listModel?.widget_data?.count
        {
            let data = listModel?.widget_data![index * 2]
            if data?.link != nil && clickClosure != nil
            {
                clickClosure!((data?.link)!)
            }
        }
        
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
