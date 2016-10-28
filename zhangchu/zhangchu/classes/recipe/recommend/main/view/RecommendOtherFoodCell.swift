//
//  RecommendOtherFoodCell.swift
//  zhangchu
//
//  Created by 苏宁 on 2016/10/28.
//  Copyright © 2016年 suning. All rights reserved.
//

import UIKit

class RecommendOtherFoodCell: UITableViewCell {
    
    var clickClosure:RecipClickClosure?
    
    var listModel:RecipeRecommendWidgetList?{
        didSet{
            showData()
        }
    }
    
    func showData()
    {
        //左
        
        //图
        if listModel?.widget_data?.count > 0
        {
            let sceneData = listModel?.widget_data![0]
            sceneBtn.kf_setBackgroundImageWithURL(NSURL(string: (sceneData?.content)!), forState: .Normal)
            sceneBtn.contentMode = .ScaleAspectFill
        }
        //name
        if listModel?.widget_data?.count > 1
        {
            let nameData = listModel?.widget_data![1]
            nameLabel.text = nameData?.content
        }
        //num
        if listModel?.widget_data?.count > 2
        {
            let naumData = listModel?.widget_data![2]
            numLabel.text = naumData?.content
        }
        
        //右
        for i in 0 ..< 4
        {
            //图
            if listModel?.widget_data?.count > i * 2 + 3
            {
                let btnData = listModel?.widget_data![i * 2 + 3]
                if btnData?.type == "image"
                {
                    let tmpView = contentView.viewWithTag(100 + i)
                    if tmpView?.isKindOfClass(UIButton) == true
                    {
                        let btn = tmpView as! UIButton
                        btn.kf_setBackgroundImageWithURL(NSURL(string: (btnData?.content)!), forState: .Normal)
                        btn.contentMode = .ScaleAspectFill
                    }
                }
            }
            
            //视频
        }
        
        //desc
        descLabel.text = listModel?.desc
        
    }
    
    @IBOutlet weak var sceneBtn: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var numLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    
    @IBAction func sceneBtnClick(sender: UIButton)
    {
        if listModel?.widget_data?.count > 0
        {
            let sceneData = listModel?.widget_data![0]
            if sceneData?.link != nil && clickClosure != nil
            {
                clickClosure!((sceneData?.link)!)
            }
        }
    }
    
    @IBAction func imgBtnClick(sender: UIButton)
    {
        let index = sender.tag - 100
        if listModel?.widget_data?.count > index * 2 + 3
        {
            let data = listModel?.widget_data![index * 2 + 3]
            if data?.link != nil && clickClosure != nil
            {
                clickClosure!((data?.link)!)
            }
        }
    }
    
    @IBAction func playBtnClick(sender: UIButton)
    {
        let index = sender.tag - 200
        if listModel?.widget_data?.count > index * 2 + 4
        {
            let data = listModel?.widget_data![index * 2 + 4]
            if data?.content != nil && clickClosure != nil
            {
                clickClosure!((data?.content)!)
            }
        }
    }

    //创建cell
    class func createTodayCell(tableView: UITableView, atIndexPath indexPath:NSIndexPath, listModel:RecipeRecommendWidgetList?) ->RecommendOtherFoodCell
    {
        let cellID = "recommendOtherFoodCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellID) as? RecommendOtherFoodCell
        if cell == nil
        {
            cell = NSBundle.mainBundle().loadNibNamed("RecommendOtherFoodCell", owner: nil, options: nil).last as? RecommendOtherFoodCell
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
