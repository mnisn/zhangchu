//
//  RecommentChosenCell.swift
//  zhangchu
//
//  Created by 苏宁 on 2016/10/31.
//  Copyright © 2016年 suning. All rights reserved.
//

import UIKit

class RecommentChosenCell: UITableViewCell {
    
    var clickClosure:RecipClickClosure?
    var listModel:RecipeRecommendWidgetList?{
        didSet{
            showData()
        }
    }
    
    //视图点击
    @IBAction func btnClick(sender: UIButton)
    {
        let index = sender.tag - 100
        if listModel?.widget_data?.count > index * 3
        {
            let data = listModel?.widget_data![index * 3]
            if data?.link != nil && clickClosure != nil
            {
                clickClosure!((data?.link)!)
            }
        }
    }
    //头像点击
    @IBAction func userBtnClick(sender: UIButton)
    {
        let index = sender.tag - 300
        if listModel?.widget_data?.count > index * 3 + 1
        {
            let data = listModel?.widget_data![index * 3 + 1]
            if data?.link != nil && clickClosure != nil
            {
                clickClosure!((data?.link)!)
            }
        }
    }
    
    @IBOutlet weak var descLabel: UILabel!
    
    func showData()
    {
        if listModel?.widget_data?.count > 0
        {
            for i in 0 ..< 3
            {
                //i * 3
                if listModel?.widget_data?.count > i * 3
                {
                    let imgData = listModel?.widget_data![i * 3]
                    if imgData?.type == "image"
                    {
                        let tmpView = contentView.viewWithTag(200 + i)
                        if tmpView?.isKindOfClass(UIImageView) == true
                        {
                            let imgView = tmpView as! UIImageView
                            imgView.kf_setImageWithURL(NSURL(string: (imgData?.content)!), placeholderImage: UIImage(named: "sdefaultImage"))
                        }
                    }
                }
                //i * 3 + 1
                if listModel?.widget_data?.count > i * 3 + 1
                {
                    let userImgData = listModel?.widget_data![i * 3 + 1]
                    if userImgData?.type == "image"
                    {
                        let tmpView = contentView.viewWithTag(300 + i)
                        if tmpView?.isKindOfClass(UIButton) == true
                        {
                            let userBtn = tmpView as! UIButton
                            userBtn.kf_setBackgroundImageWithURL(NSURL(string: (userImgData?.content)!), forState: .Normal)
                            userBtn.layer.cornerRadius = 15
                            userBtn.layer.masksToBounds = true
                        }
                    }
                }
                //i * 3 + 2
                if listModel?.widget_data?.count > i * 3 + 2
                {
                    let nameLabelData = listModel?.widget_data![i * 3 + 2]
                    if nameLabelData?.type == "text"
                    {
                        let tmpView = contentView.viewWithTag(400 + i)
                        if tmpView?.isKindOfClass(UILabel) == true
                        {
                            let nameLabel = tmpView as! UILabel
                            nameLabel.text = nameLabelData?.content
                        }
                    }
                }
            }
            
            //
            descLabel.text = listModel?.desc
        }
        
    }
    
    //创建cell
    class func createChonsenCell(tableView: UITableView, atIndexPath indexPath:NSIndexPath, listModel:RecipeRecommendWidgetList?) ->RecommentChosenCell
    {
        let cellID = "recommentChosenCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellID) as? RecommentChosenCell
        if cell == nil
        {
            cell = NSBundle.mainBundle().loadNibNamed("RecommentChosenCell", owner: nil, options: nil).last as? RecommentChosenCell
        }
        cell?.listModel = listModel!
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
